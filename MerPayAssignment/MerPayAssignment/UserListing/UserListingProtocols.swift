//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

protocol UserListingViewProtocol {
    var presentor : UserListingPresentor? {get set}
    
    func append(users: [User])
    func show(users: [User])
}

protocol UserListingRouterProtocol {
    func pushChatController(over controller: UINavigationController, for user: User)
}

protocol UserListingPresentorProtocol {
    //View Related functions
    var view : UserListingController? { get set }
    
    func append(users: [User])
    func show(users: [User])
    
    //Interactor Related functions
    var interactor: UserListingInteractor? { get set }
    
    var router : UserListingRouter? { get set }
    
    func viewLoaded()
    func userSelected(from controller: UINavigationController, selected selectedUser: User)
    func getUserList()
    func getNextUserList()
    func getSearchedUserList(for searchText: String)
    func getNextSearchedUserList(for searchText: String)
}

protocol UserListingInteractorProtocol {
    var networkManager : NetworkManager? { get set }
    func getUserList()
    func getNextUserList()
    func getSearchedUserList(for searchText: String)
}

protocol UserListingInteractorOutputProtocol {
    var presentor : UserListingPresentor? { get set }
}
