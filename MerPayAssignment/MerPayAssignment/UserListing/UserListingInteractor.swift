//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

class UserListingInteractor : UserListingInteractorProtocol, UserListingInteractorOutputProtocol {
    
    //MARK:- Vars
    //MARK: Public
    var networkManager : NetworkManager?
    var presentor : UserListingPresentor?
    var chatManager = ChatCoreDataManager(date: Date())
    
    //MARK:- Init
    init() {
        networkManager = NetworkManager()
        networkManager?.delegate = self
    }
    
    //MARK:- Public functions
    func getUserList() {
        networkManager?.get(callBack: { [weak self] success, response, error in
            var users = [User]()
            if let data = response as? Data, let parsedUsers = self?.getUsers(from: data) {
                users = parsedUsers
            }
            self?.presentor?.show(users: users)
        })
    }
    
    func getNextUserList() {
        
    }
    
    func getSearchedUserList(for searchText: String) {
        
    }
    
    func getConversations() -> [ConversationEntity] {
        return chatManager.getConversations(from: LOGGED_IN_USER)
    }
    
    //MARK:- Private functions
    private func getUsers(from responseData: Data) -> [User] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var users = [User]()
        if let parsedUsers = try? decoder.decode([User].self, from: responseData) {
            users = parsedUsers
        }
        return users
    }
}

//MARK:- NetworkInputProtocol
extension UserListingInteractor : NetworkInputProtocol {
    @objc func getUrl() -> String {
        return URL_STRING
    }
    
    @objc func compulsoryPathParam() -> [String] {
        return ["users"]
    }
    
    @objc func compulsoryQueryParam() -> [String : String] {
        return [:]
    }
    
    @objc func compulsoryHeaders() -> [String : String] {
        return [:]
    }
}
