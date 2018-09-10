//
//  UserListingInteractor.swift
//  ChatBot
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

class ChatsInteractor : ChatsInteractorProtocol {
    
    //MARK:- Vars
    //MARK: Public
    var userName: String?
    var networkManager : NetworkProtocol?
    var presenter : ChatsPresenter?
    
    //MARK: Private
    private var conversation : ConversationEntity?
    private var chatManager = ChatCoreDataManager()
    
    //MARK:- Init
    init(networkHandler: NetworkProtocol, userName: String) {
        self.networkManager = networkHandler
        self.userName = userName
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
        }
    }
    
    /// Invokes when someone sends a message
    ///
    /// - Parameter message: a single message entity/
    func showReceived(message: MessageEntity) {
        presenter?.showRecieved(message: message)
    }
    
    /// Load a single conversation from the username that is set the interactor.
    func loadMessages() {
        if let userName = userName {
            conversation = chatManager.getConversation(fromUserName: LOGGED_IN_USER, toUserName: userName)
            presenter?.show(conversation: conversation!)
        }
    }
    
    /// Conversation will be store is any chat is been done.
    func saveConversation() {
        if conversation?.messageArchieves?.count == 0, let thisConversation = conversation {
            CoreDataStack.shared.context.delete(thisConversation)
        }
    }
}
