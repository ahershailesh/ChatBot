//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class UserListingPresentor : UserListingPresentorProtocol {
    
    //MARK:- Vars
    //MARK: Public
    var view : UserListingController?
    var interactor: UserListingInteractor?
    var router: UserListingRouter?
    
    private var userNameArray : [String] = []
    
    //MARK:- Public functions
    
    func show(users: [User]) {
        let models = users.map { (user) -> UserInfoCellViewModel in
            return getUserCellViewModel(from: user)
        }
        view?.show(models: models)
    }
    
    func append(users: [User]) {
        let models = users.map { (user) -> UserInfoCellViewModel in
            return getUserCellViewModel(from: user)
        }
        view?.append(models: models)
    }
    
    
    func viewLoaded() {
        loadConversations()
//        interactor?.getUserList()
    }
    
    private func loadConversations() {
        let models = getConversations()
        updateUserNameArray(models: models)
        view?.show(models: models)
    }
    
    private func updateUserNameArray(models : [UserInfoCellViewModel]) {
        userNameArray = models.compactMap { $0.userName }
    }
    
    private func getConversations() -> [UserInfoCellViewModel] {
        let conversations = interactor?.getConversations()
        return conversations?.map({ (entity) -> UserInfoCellViewModel in
            return getUserCellViewModel(from: entity)
        }) ?? []
    }
    
    private func getUserCellViewModel(from conversation: ConversationEntity) -> UserInfoCellViewModel {
        let viewModel = UserInfoCellViewModel()
        let message = conversation.messageArchieveArray.last?.messagesArray.last
        viewModel.lastChat = message?.text
        viewModel.userName = conversation.toUser
        if let date = message?.date {
            viewModel.lastChatTime = date.getDateDisplay()
        }
        return viewModel
    }
    
    private func getUserCellViewModel(from user: User) -> UserInfoCellViewModel {
        let viewModel = UserInfoCellViewModel()
        viewModel.userName = user.login
        viewModel.userProfilePicLink = user.avatarUrl?.absoluteString
        return viewModel
    }
    
   func userSelected(from controller: UINavigationController, for selected: UserInfoCellViewModel) {
        let headerViewModel = HeaderViewModel()
        headerViewModel.profilePicLink = selected.userProfilePicLink
        headerViewModel.subTitleText = selected.lastChatTime
        headerViewModel.titleText = selected.userName
        router?.pushChatController(over: controller, for: headerViewModel)
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
