//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class UserListingPresentor : UserListingPresentorProtocol {
    
    var router: UserListingRouter?

    //View Related functions
    var view : UserListingController?
    
    func append(users: [User]) {
        
    }
    
    func show(users: [User]) {
        view?.show(users: users)
    }
    
    //Interactor Related functions
    var interactor: UserListingInteractor?
    
    func viewLoaded() {
        interactor?.getUserList()
    }
    
    func userSelected(from controller: UINavigationController, selected selectedUser: User) {
        router?.pushChatController(over: controller, for: selectedUser)
    }
    
    func getUserList() {
        
    }
    
    func getNextUserList() {
        
    }
    
    func getSearchedUserList(for searchText: String) {
        
    }
    
    func getNextSearchedUserList(for searchText: String) {
        
    }
}
