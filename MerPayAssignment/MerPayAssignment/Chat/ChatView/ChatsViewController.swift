//
//  ChatControllerViewController.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var messageTextView: UITextView?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var textViewBackgroundView: UIView?
    
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint?
    @IBAction func sendButtonTapped(_ sender: Any) {
        messageTextView?.resignFirstResponder()
        if let text = messageTextView?.text, !text.isEmpty {
            let message = Message()
            message.text = text
            message.date = Date()
            presentor?.sendMessage(message)
        }
        self.textViewHeightConstraint?.constant = DEFAULT_TEXTVIEW_HEIGHT
        messageTextView?.text = nil
    }
    
    var user : User?
    var archieves = [MessageArchieveViewModel]()
    var presentor: ChatsPresentor?
    private let MESSGAE_CELL_ID = "MessageTableViewCell"
    private let DEFAULT_TEXTVIEW_HEIGHT : CGFloat = 56.0
    private let MAX_TEXTVIEW_HEIGHT : CGFloat = 100.0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupNavigationView()
        registerCell()
        tableView?.dataSource = self
        messageTextView?.delegate = self
        setupView()
        registerForKeyboardNotification()
        presentor?.viewLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func registerCell() {
        tableView?.register(MessageTableViewCell.self, forCellReuseIdentifier: MESSGAE_CELL_ID)
    }
    
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        view.layoutIfNeeded()
        let info  = notification.userInfo!
        let frame: AnyObject = info[UIKeyboardFrameEndUserInfoKey]! as AnyObject
        let rawFrame = frame.cgRectValue ?? .zero
        let keyboardFrame = view.convert(rawFrame, from: nil)
        
        let time = info[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: time) {
            self.bottomConstraint?.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.layoutIfNeeded()
        let info  = notification.userInfo!
        let time = info[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: time) {
            self.bottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupView() {
        messageTextView?.clipsToBounds = true
        messageTextView?.layer.cornerRadius = 8
        
        messageTextView?.layer.borderWidth = 1
        messageTextView?.layer.borderColor = ColorHex.lightGray.getColor().cgColor
        
        textViewBackgroundView?.layer.borderWidth = 1
        textViewBackgroundView?.layer.borderColor = ColorHex.lightGray.getColor().cgColor
    }
    
    //MARK:- Navigation bar handling
    private func setupNavigationView() {
        if let navigationView = getNavigationView() {
            navigationView.user = user
            navigationView.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 100))
            navigationItem.titleView = navigationView
        }
    }
    
    private func getNavigationView() -> NavigationView? {
        return NavigationView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 100)))
    }
}

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

extension ChatsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ChatsViewController : ChatsViewProtocol {
    func show(message: MessageViewModel) {
        if let archieve = archieves.last {
            archieve.messages.append(message)
            if let indexPath = getLastIndexPath() {
                tableView?.insertRows(at: [indexPath], with: .bottom)
                tableView?.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            }
        }
    }
    
    func showArchieves(with archieves: [MessageArchieveViewModel]) {
        self.archieves = archieves
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
}

extension ChatsViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.1) {
            if textView.textInputView.frame.height < self.MAX_TEXTVIEW_HEIGHT {
                self.textViewHeightConstraint?.constant = textView.textInputView.frame.height + 25
            }
            self.view.layoutIfNeeded()
        }
        
    }
}
