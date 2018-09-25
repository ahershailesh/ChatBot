//
//  UserListingInteractor.swift
//  ChatBot
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

class UserListingInteractor : UserListingInteractorProtocol, UserListingInteractorOutputProtocol {
    
    //MARK:- Vars
    //MARK: Public
    var networkManager : NetworkManager?
    var presenter : UserListingPresenter?
    var chatManager = ChatCoreDataManager(date: Date())
    
    private var lastUserId = 0
    
    //MARK:- Init
    init() {
        networkManager = NetworkManager()
        networkManager?.delegate = self
    }
    
    //MARK:- Public functions
    func getUserList(shouldRefresh: Bool = false) {
        lastUserId = shouldRefresh ? 0 : lastUserId
        networkManager?.get(callBack: { [weak self] success, response, error in
            var users = [User]()
            if success, let data = response as? Data, let parsedUsers = self?.getUsers(from: data) {
                users = self?.sort(users: parsedUsers) ?? []
                self?.saveLastId(from: users)
            }
            shouldRefresh ? self?.presenter?.show(users: users) : self?.presenter?.append(users: users)
        })
    }
    
    private func sort(users: [User]) -> [User] {
        return users.sorted { (user1, user2) -> Bool in
            return (user1.id ?? 0) < (user2.id ?? 0)
        }
    }

    private func saveLastId(from users: [User]) {
        if let user = users.last {
            lastUserId = user.id ?? 0
        }
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
        return ["since": String(describing: lastUserId) ]
    }
    
    @objc func compulsoryHeaders() -> [String : String] {
        return [:]
    }
}
