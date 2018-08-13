//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

class ChatsInteractor : ChatsInteractorProtocol {
    
    //MARK:- Vars
    //MARK: Public
    var user: User?
    var networkManager : NetworkProtocol?
    var presentor : ChatsPresentor?
    
    //MARK: Private
    private var conversation : ConversationEntity?
    private var chatManager = ChatCoreDataManager()
    
    //MARK:- Init
    init(networkHandler: NetworkProtocol, user: User) {
        self.networkManager = networkHandler
        self.user = user
    }
    
    //MARK:- Private functions
    private func checkIfMessageValid(message: Message) -> Bool {
        if !(message.text?.isEmpty ?? true) {
            return true
        }
        return false
    }
    
    //MARK:- Public functions
    func send(message: Message) {
        guard checkIfMessageValid(message: message) else { print("Message is not valid"); return }
        //First post the message
        networkManager?.post(url: nil, pathParam: nil, queryParam: nil, headers: nil, bodyString: message.text, callBack: { [weak self] (success, _, _) in
            if success {
                self?.saveMessageToLocal(message)
            }
        })
    }
    
    func getUserDetails(of userName: String) {
        
    }
    
    /// Save chat to local core data
    ///
    /// - Parameter message: Message model data
    func saveMessageToLocal(_ message: Message) {
        //If post successful, save message to the core-data
        if let thisConversation = conversation  {
            //If coredata save is successful, load the message in chat View
            if let entity = chatManager.save(message: message, to: thisConversation) {
                showReceived(message: entity)
            }
        } else {
            presentor?.showError()
        }
    }
    
    func showReceived(message: MessageEntity) {
        presentor?.showRecieved(message: message)
    }
    
    func loadMessages() {
        if let userName = user?.login {
            conversation = chatManager.getConversation(fromUserName: LOGGED_IN_USER, toUserName: userName)
            presentor?.show(conversation: conversation!)
        }
    }
}
