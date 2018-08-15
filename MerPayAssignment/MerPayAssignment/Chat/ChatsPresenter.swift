//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class ChatsPresenter : ChatsPresenterProtocol {
    var view: ChatsViewController?
    
    var interactor: ChatsInteractor?
    
    var router: ChatsRouter?
    
    //from View
    func viewLoaded() {
        interactor?.loadMessages()
    }
    
    func sendMessage(_ message: Message) {
        interactor?.send(message: message)
    }
    
    //From Interactor
    func show(conversation: ConversationEntity) {
        var archieves = getConvertedArchieves(from: conversation)
        if archieves.isEmpty {
            let model = MessageArchieveViewModel()
            model.dateString = NSDate().getDateString()
            model.messages = []
           archieves = [model]
        }
        view?.show(archieves: archieves)
    }
    
    func showRecieved(message: MessageEntity) {
        let model = getConvetedMessage(from: message)
        view?.show(message: model)
    }
    
    func showError() {
        
    }
    
    func sendMessage(_ messageModel: MessageViewModel) {
        let message = Message()
        message.text = messageModel.text
        message.date = Date()
        interactor?.send(message: message)
    }
    
    func saveConversation() {
        interactor?.saveConversation()
    }
}

//MARK:- Model to ViewModel convertor
extension ChatsPresenter {
    private func getConvertedArchieves(from conversation: ConversationEntity) -> [MessageArchieveViewModel]{
        return conversation.messageArchieveArray.map { (messageArchieve) -> MessageArchieveViewModel in
            return getConvertedArchieve(from: messageArchieve)
        }
    }
    
    private func getConvertedArchieve(from entity: MessageArchieveEntity) -> MessageArchieveViewModel {
        let messages = entity.messagesArray.map({ [unowned self] (entity) -> MessageViewModel in
            return self.getConvetedMessage(from: entity)
        })
        let model = MessageArchieveViewModel()
        model.dateString = entity.date!.getDateString()
        model.messages = messages
        return model
    }
    
    private func getConvetedMessage(from entity: MessageEntity) -> MessageViewModel {
        let type : MessageType = entity.fromUserName == LOGGED_IN_USER ? .sent : .recieved
        let model = MessageViewModel()
        model.time = entity.date?.getTimeString()
        model.text = entity.text
        model.type = type
        return model
    }
}
