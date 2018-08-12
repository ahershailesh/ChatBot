//
//  ViewController.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/9/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

enum UserTableViewStatus {
    case loading
    case listing
    case searching
}

class UserListingController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var searchBar: UITextField?
    @IBOutlet weak var tableView: UITableView?
    
    //Constants
    private let USER_INFO_CELL_IDENTIFIER = "UserDetailInfoCell"
    private let LOADING_CELL_INDETIFIER = "LoadingCell"
    private let NO_DATA_CELL_IDENTIFIER = "NoResultCell"
    private let LOADING_CELL_MESSAGE = "Loading users"
    
    private var status : UserTableViewStatus = .listing {
        didSet {
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    private var userList = [User]()
    var presentor: UserListingPresentor?
    
    //MARK:- Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        registerCells()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = .singleLine
        
        loadUsers()
    }
    
    func loadUsers() {
        status = .loading
        presentor?.viewLoaded()
    }
    
    func registerCells() {
        tableView?.register(UINib(nibName: "UserDetailInfoCell", bundle: nil), forCellReuseIdentifier: USER_INFO_CELL_IDENTIFIER)
        tableView?.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: LOADING_CELL_INDETIFIER)
        tableView?.register(UINib(nibName: "NoResultCell", bundle: nil), forCellReuseIdentifier: NO_DATA_CELL_IDENTIFIER)
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        loadUsers()
    }
    
}

//MARK:- UITableViewDataSource
extension UserListingController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch status {
        case .loading: return 1
        case .listing: return userList.isEmpty ? 1 : userList.count
        case .searching: return userList.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch status {
        case .loading: return getLoadingCell(for: tableView, and: indexPath)
        case .listing: return getUserCell(for: tableView, and: indexPath)
        case .searching: return getSearchingCell(for: tableView, and: indexPath)
        }
    }
    
    private func getLoadingCell(for tableView: UITableView, and indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LOADING_CELL_INDETIFIER, for: indexPath) as! LoadingCell
        cell.setMessage(text: LOADING_CELL_MESSAGE)
        return cell
    }
    
    private func getUserCell(for tableView: UITableView, and indexPath: IndexPath) -> UITableViewCell {
        
        if userList.isEmpty {
            return getNoDataCell(for: tableView, and: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: USER_INFO_CELL_IDENTIFIER, for: indexPath) as! UserDetailInfoCell
        let user = userList[indexPath.row]
        cell.user = user
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    private func getNoDataCell(for tableView: UITableView, and indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NO_DATA_CELL_IDENTIFIER, for: indexPath)
        return cell
    }
    
    private func getSearchingCell(for tableView: UITableView, and indexPath: IndexPath) -> UITableViewCell {
        //Check if tableview is asking for last cell
        if indexPath.count - 1 == indexPath.row {
            return getLoadingCell(for: tableView, and: indexPath)
        }
        return getUserCell(for: tableView, and: indexPath)
    }
}

//MARK:- UITableViewDelegate
extension UserListingController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = userList[indexPath.row]
        presentor?.userSelected(from: navigationController!, selected: user)
    }
}

//MARK:- UserListingViewProtocol
extension UserListingController : UserListingViewProtocol {
    func append(users: [User]) {
        userList.append(contentsOf: users)
        status = .listing
    }
    
    func show(users: [User]) {
        userList = users
        status = .listing
    }
}
