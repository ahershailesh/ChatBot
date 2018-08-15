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

enum UserListingSection : String {
    case recent = "Recent Conversations"
    case other = "Other Conversations"
}

class UserListingController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var headerView: UIView?
    
    //Constants
    private let USER_INFO_CELL_IDENTIFIER = "UserDetailInfoCell"
    private let LOADING_CELL_INDETIFIER = "LoadingCell"
    private let NO_DATA_CELL_IDENTIFIER = "NoResultCell"
    private let HEADER_SECTION_IDENTIFIER = "HeaderFooterCell"
    private let LOADING_CELL_MESSAGE = "Loading users"
    
    private var sectionOrder : [UserListingSection] = [.other]
    private var recentConversations : [UserInfoCellViewModel] = []
    private var otherConversations : [UserInfoCellViewModel] = []
    
    private var status : UserTableViewStatus = .listing
    var presenter: UserListingPresenter?
    
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
        navigationController?.navigationBar.isHidden = false
        
        registerCells()
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = .singleLine
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        
//        headerView?.layer.borderWidth = 1
//        headerView?.layer.borderColor = ColorHex.lightGray.getColor().cgColor
        
        presenter?.getUserList(shouldRefresh: true)
        
        navigationController?.navigationBar.barTintColor = ColorHex.navigationBarColor.getColor()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func loadNextUsers() {
        presenter?.getUserList(shouldRefresh: false)
    }
    
    @objc private func refreshData() {
        recentConversations = []
        otherConversations = []
        status = .loading
        presenter?.viewLoaded()
        presenter?.getUserList(shouldRefresh: true)
    }
    
    private func registerCells() {
        tableView?.register(UINib(nibName: "UserDetailInfoCell", bundle: nil), forCellReuseIdentifier: USER_INFO_CELL_IDENTIFIER)
        tableView?.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: LOADING_CELL_INDETIFIER)
        tableView?.register(UINib(nibName: "NoResultCell", bundle: nil), forCellReuseIdentifier: NO_DATA_CELL_IDENTIFIER)
        tableView?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HEADER_SECTION_IDENTIFIER)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewLoaded()
    }
}

//MARK:- UITableViewDataSource
extension UserListingController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionOrder.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let listingSection = sectionOrder[section]
        if listingSection == .recent {
            return recentConversations.count
        }
        switch status {
        case .loading: return 1
        case .listing: return otherConversations.isEmpty ? 1 : otherConversations.count
        case .searching: return otherConversations.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch status {
        case .loading: return getLoadingCell(for: tableView, and: indexPath)
        case .listing: return getUserCell(for: tableView, and: indexPath)
        case .searching: return getSearchingCell(for: tableView, and: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HEADER_SECTION_IDENTIFIER)
        sectionView?.textLabel?.text = sectionOrder[section].rawValue
        sectionView?.backgroundColor = ColorHex.navigationBarColor.getColor()
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    private func getLoadingCell(for tableView: UITableView, and indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LOADING_CELL_INDETIFIER, for: indexPath) as! LoadingCell
        cell.setMessage(text: LOADING_CELL_MESSAGE)
        return cell
    }
    
    private func getUserCell(for tableView: UITableView, and indexPath: IndexPath) -> UITableViewCell {
        let section = sectionOrder[indexPath.section]
        let array = section == .recent ? recentConversations : otherConversations
        if array.isEmpty {
            return getNoDataCell(for: tableView, and: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: USER_INFO_CELL_IDENTIFIER, for: indexPath) as! UserDetailInfoCell
        let model = array[indexPath.row]
        cell.model = model
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    private func getNoDataCell(for tableView: UITableView, and indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NO_DATA_CELL_IDENTIFIER, for: indexPath)
        tableView.separatorStyle = .none
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
        let section = sectionOrder[indexPath.section]
        let array = section == .recent ? recentConversations : otherConversations
        let model = array[indexPath.row]
        presenter?.userSelected(from: self.navigationController!, for: model)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if otherConversations.count - 5 == indexPath.row {
//            status = .loading
            loadNextUsers()
        }
    }
}

//MARK:- UserListingViewProtocol
extension UserListingController : UserListingViewProtocol {
    func append(models: [UserInfoCellViewModel]) {
        let conversations = removeDuplicateUser(from: models)
        let startIndex = otherConversations.count
        let endIndex = otherConversations.count + conversations.count
        otherConversations.append(contentsOf: conversations)
        if let section = sectionOrder.index(of: .other) {
            var indexPaths : [IndexPath] = []
            for index in startIndex..<endIndex {
                indexPaths.append(IndexPath(row: index, section: section))
            }
            DispatchQueue.main.async {
                self.tableView?.insertRows(at: indexPaths, with: .fade)
            }
        }
    }
 
    func show(models: [UserInfoCellViewModel], for section: UserListingSection) {
        switch section {
        case .recent:
            recentConversations = models
            if !recentConversations.isEmpty {
                sectionOrder = [.recent, .other]
            }
            otherConversations = removeDuplicateUser(from: otherConversations)
        case .other:
            otherConversations = removeDuplicateUser(from: models)
        }
        status = .listing
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    private func removeDuplicateUser(from users: [UserInfoCellViewModel]) -> [UserInfoCellViewModel] {
        if users.isEmpty || recentConversations.isEmpty { return users }
        let recentUserNames = recentConversations.compactMap { $0.userName }
        return users.filter { (model) -> Bool in
            guard let userName = model.userName else { return false }
            return !recentUserNames.contains(userName)
        }
    }
}
