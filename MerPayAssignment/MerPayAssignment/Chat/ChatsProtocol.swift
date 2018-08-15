//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

protocol ChatsViewProtocol {
    var presenter : ChatsPresenter? {get set}
    
    //presenter will talk to the view with below methods
    func show(message: MessageViewModel)
    func show(archieves: [MessageArchieveViewModel])
}

protocol ChatsRouterProtocol {
    
}

protocol ChatsPresenterProtocol {
    //View will talk to presenter with following commands
    var view : ChatsViewController? { get set }

    func viewLoaded()
    func sendMessage(_ message: MessageViewModel)
    
    //interactor will talk to presenter with following commands
    var interactor: ChatsInteractor? { get set }
    
    func show(conversation: ConversationEntity)
    func showRecieved(message: MessageEntity)
    func showError()
    
    var router : ChatsRouter? { get set }
}

protocol ChatsInteractorProtocol {
    var networkManager : NetworkProtocol? { get set }
    var userName: String? { get set }
    
    func loadMessages()
    func send(message: Message)
    func saveMessageToLocal(_ message: Message)
}

protocol ChatsInteractorOutputProtocol {
    var presenter : ChatsPresenter? { get set }
    
    func show(message: MessageViewModel)
    func loadConversation(with archieves: [MessageArchieveViewModel])
}
