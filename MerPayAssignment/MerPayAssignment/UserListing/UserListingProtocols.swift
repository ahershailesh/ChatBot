//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

protocol UserListingViewProtocol {
    var presenter : UserListingPresenter? {get set}
    
    func append(models: [UserInfoCellViewModel])
    func show(models: [UserInfoCellViewModel], for section: UserListingSection) 
}

protocol UserListingRouterProtocol {
    func pushChatController(over controller: UINavigationController, for user: HeaderViewModel)
}

protocol UserListingPresenterProtocol {
    //View Related functions
    var view : UserListingController? { get set }
    
    func append(users: [User])
    func show(users: [User])
    
    //Interactor Related functions
    var interactor: UserListingInteractor? { get set }
    
    var router : UserListingRouter? { get set }
    
    func viewLoaded()
    func userSelected(from controller: UINavigationController, for selected: UserInfoCellViewModel)
    func getUserList(shouldRefresh: Bool)
    func getSearchedUserList(for searchText: String)
    func getNextSearchedUserList(for searchText: String)
}

protocol UserListingInteractorProtocol {
    var networkManager : NetworkManager? { get set }
    func getUserList(shouldRefresh: Bool)
    func getSearchedUserList(for searchText: String)
}

protocol UserListingInteractorOutputProtocol {
    var presenter : UserListingPresenter? { get set }
}
