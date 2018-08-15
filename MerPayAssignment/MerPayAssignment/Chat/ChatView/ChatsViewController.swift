//
//  ChatControllerViewController.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {
    
    //MARK:- Vars
    //IBOutlet
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var messageTextView: UITextView?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    @IBOutlet weak var textViewBackgroundView: UIView?
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint?
    
    
    //MARK: Private vars
    private var headerView: NavigationView?
    private var lastMessageDateAndTime = "Last message on "
    
    //MARK: Public vars
    var headerViewModel : HeaderViewModel?
    var archieves = [MessageArchieveViewModel]()
    var presentor: ChatsPresentor?
    
    //MARK: Public Constants
    private let MESSGAE_CELL_ID = "MessageTableViewCell"
    private let DEFAULT_STACKVIEW_HEIGHT : CGFloat = 36
    private let MAX_TEXTVIEW_HEIGHT : CGFloat = 100.0
    private let DEFAULT_BOTTOM_CONSTANT : CGFloat = -16
    
    //MARK:- Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupNavigationView()
        registerCell()
        tableView?.dataSource = self
        tableView?.delegate = self
        messageTextView?.delegate = self
        setupView()
        registerForKeyboardNotification()
        presentor?.viewLoaded()
    }
    
    //MARK:- IBAction
    @IBAction func sendButtonTapped(_ sender: Any) {
        if let text = messageTextView?.text, !text.isEmpty {
            let message = Message()
            message.text = text
            message.date = Date()
            presentor?.sendMessage(message)
        }
        self.stackViewHeightConstraint?.constant = DEFAULT_STACKVIEW_HEIGHT
        messageTextView?.text = nil
    }
    
    
    //MARK:- Private methods
    private func registerCell() {
        tableView?.register(MessageTableViewCell.self, forCellReuseIdentifier: MESSGAE_CELL_ID)
    }
    
    private func setupView() {
        messageTextView?.clipsToBounds = true
        messageTextView?.layer.cornerRadius = 8
        
        messageTextView?.layer.borderWidth = 1
        messageTextView?.layer.borderColor = ColorHex.lightGray.getColor().cgColor
        
        textViewBackgroundView?.layer.borderWidth = 1
        textViewBackgroundView?.layer.borderColor = ColorHex.lightGray.getColor().cgColor
    }
    
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: Keyboard handling
    @objc private func keyboardWillShow(_ notification: Notification) {
        view.layoutIfNeeded()
        let info  = notification.userInfo!
        let frame: AnyObject = info[UIKeyboardFrameEndUserInfoKey]! as AnyObject
        let rawFrame = frame.cgRectValue ?? .zero
        let keyboardFrame = view.convert(rawFrame, from: nil)
        
        let time = info[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: time) {
            var bottomConstants = (-1) * keyboardFrame.height
            if !IS_IPHONE_X {
                bottomConstants = bottomConstants + self.DEFAULT_BOTTOM_CONSTANT
            }
            self.bottomConstraint?.constant = bottomConstants
            self.view.layoutIfNeeded()
        }
        tableView?.scrollToNearestSelectedRow(at: .bottom, animated: false)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.layoutIfNeeded()
        let info  = notification.userInfo!
        let time = info[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: time) {
            self.bottomConstraint?.constant = self.DEFAULT_BOTTOM_CONSTANT
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: Navigation bar handling
    private func setupNavigationView() {
        headerView = NavigationView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 100)))
        headerView?.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 100))
        navigationItem.titleView = headerView
        headerView?.model = headerViewModel
    }
}

//MARK:- UITableViewDataSource
extension ChatsViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return archieves.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return archieves[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MESSGAE_CELL_ID, for: indexPath) as! MessageTableViewCell
        cell.messageViewModel = archieves[indexPath.section].messages[indexPath.row]
        return cell
    }
}

//MARK:- UITableViewDelegate
extension ChatsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        messageTextView?.resignFirstResponder()
    }
}

//MARK:- UITextViewDelegate
extension ChatsViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.1) {
            if textView.textInputView.frame.height < self.MAX_TEXTVIEW_HEIGHT {
                let height = textView.textInputView.frame.height + 25
                self.stackViewHeightConstraint?.constant = height
            }
            self.view.layoutIfNeeded()
        }
    }
}

//MARK:- ChatsViewProtocol
extension ChatsViewController : ChatsViewProtocol {
    func show(message: MessageViewModel) {
        if let archieve = archieves.last {
            archieve.messages.append(message)
            if let indexPath = getLastIndexPath() {
                tableView?.insertRows(at: [indexPath], with: .bottom)
                tableView?.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
        }
        setLastDateOnHeader(from: message)
    }
    
    func show(archieves: [MessageArchieveViewModel]) {
        self.archieves = archieves
        if let last = archieves.last {
            setLastDateOnHeader(from: last)
        }
        DispatchQueue.main.async {
            self.tableView?.reloadData()
            self.tableView?.selectRow(at: self.getLastIndexPath(), animated: false, scrollPosition: .bottom)
        }
    }
    
    private func getLastIndexPath() -> IndexPath? {
        var lastSection = archieves.count - 1
        var lastRow = archieves[lastSection].messages.count - 1
        if lastRow < 0 {
            if lastSection == 0 {
                return nil
            }
            lastSection = lastSection - 1
            lastRow = archieves[lastSection].messages.count - 1
        }
        return IndexPath(row: lastRow, section: lastSection)
    }
    
    private func setLastDateOnHeader(from archieve: MessageArchieveViewModel) {
        lastMessageDateAndTime += archieve.dateString ?? ""
        if let message = archieve.messages.last {
            setLastDateOnHeader(from: message)
        }
    }
    
    private func setLastDateOnHeader(from message: MessageViewModel) {
        let lastMessageDateTime = lastMessageDateAndTime + " " + (message.time ?? "--")
        headerView?.setSubtitle(text: lastMessageDateTime)
    }
}
