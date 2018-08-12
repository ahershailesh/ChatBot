//
//  ChatControllerViewController.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class ChatControllerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var messageTextView: UITextView?
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        messageTextView?.resignFirstResponder()
    }
    
    var user : User?
    var messages = [MessagesModel]()
    private let MESSGAE_CELL_ID = "MessageTableViewCell"
    
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
        setupView()
        registerForKeyboardNotification()
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
            self.bottomConstraint.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.layoutIfNeeded()
        let info  = notification.userInfo!
        let time = info[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: time) {
            self.bottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupView() {
        messageTextView?.clipsToBounds = true
        messageTextView?.layer.cornerRadius = 8
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

extension ChatControllerViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3//messages.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10//messages[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MESSGAE_CELL_ID, for: indexPath) as! MessageTableViewCell
        if indexPath.row % 3 == 0 {
            cell.alignment = .left
        } else {
            cell.alignment = .right
        }
         cell.messageLabel?.text = "You use this method to add cap insets to an image or to change the existing cap insets of an image. In both cases, you get back a new image and the original image remains untouched. For example, you can use this method to create a background image for a button with borders and corners: when the button is resized"
        return cell
    }
}

extension ChatControllerViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
