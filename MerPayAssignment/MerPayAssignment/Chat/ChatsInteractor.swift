//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

class ChatsInteractor : ChatsInteractorProtocol {
    var user: User?
    var networkManager : NetworkProtocol?
    var presentor : ChatsPresentor?
    private var conversation : ConversationEntity?
    private var chatManager = ChatCoreDataManager()
    
    
    init(networkHandler: NetworkProtocol, user: User) {
        self.networkManager = networkHandler
        self.user = user
    }
     
    func send(message: Message) {
        guard checkIfMessageValid(message: message) else { print("Message is not valid"); return }
        //First post the message
        networkManager?.post(url: nil, pathParam: nil, queryParam: nil, headers: nil, bodyString: message.text, callBack: { [weak self] (success, _, _) in
            if success {
                self?.saveMessageToLocal(message)
            }
        })
    }
    
    func saveMessageToLocal(_ message: Message) {
        //If post successful, save message to the coredata
        if let thisConversation = conversation  {
            //If coredata save is successful, load the message in chat View
            if let entity = chatManager.save(message: message, to: thisConversation) {
                showReceived(message: entity)
            }
        } else {
            presentor?.showError()
        }
    }
    
    private func checkIfMessageValid(message: Message) -> Bool {
        //TODO: Check Validity of message
        return true
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