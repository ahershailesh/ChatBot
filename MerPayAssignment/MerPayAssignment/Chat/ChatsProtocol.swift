//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

// This class contains all protocols needed to be implemented by Chat module.
// According to VIPER the responsibility is been devided among the classes.
protocol ChatsViewProtocol {
    var presenter : ChatsPresenter? {get set}
    
    //presenter will talk to the view with below methods
    func show(message: MessageViewModel)
    func show(archieves: [MessageArchieveViewModel])
}

// We are not moving from chat module to any where so this protocol is blank
// This will need in the future scope of the app.
protocol ChatsRouterProtocol {
    
}

/// Minimum methods to be implemented by Presenter
protocol ChatsPresenterProtocol {
    //View will talk to presenter with following commands
    var view : ChatsViewController? { get set }
    var router : ChatsRouter? { get set }
    
    func viewLoaded()
    func sendMessage(_ message: MessageViewModel)
    
    //interactor will talk to presenter with following commands
    var interactor: ChatsInteractor? { get set }
    
    func show(conversation: ConversationEntity)
    func showRecieved(message: MessageEntity)
    
}

/// Minimum methods to be implemented by Interactor
protocol ChatsInteractorProtocol {
    var networkManager : NetworkProtocol? { get set }
    var userName: String? { get set }
    
    func loadMessages()
    func send(message: Message)
    func saveMessageToLocal(_ message: Message)
}

// Minimum methods to be implemented by presenter to get notified by interactor.
protocol ChatsInteractorOutputProtocol {
    var presenter : ChatsPresenter? { get set }
    
    func show(message: MessageViewModel)
    func loadConversation(with archieves: [MessageArchieveViewModel])
}
