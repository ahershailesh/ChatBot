//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

protocol ChatsViewProtocol {
    var presentor : ChatsPresentor? {get set}
    
    //presentor will talk to the view with below methods
    func show(message: MessageViewModel)
    func showArchieves(with archieves: [MessageArchieveViewModel])
}

protocol ChatsRouterProtocol {
    
}

protocol ChatsPresentorProtocol {
    //View will talk to presentor with below methods
    var view : ChatsViewController? { get set }

    func viewLoaded()
    func sendMessage(_ message: MessageViewModel)
    
    //interactor will talk to presentor with below methods
    var interactor: ChatsInteractor? { get set }
    
    func show(conversation: ConversationEntity)
    func showRecieved(message: MessageEntity)
    func showError()
    
    var router : ChatsRouter? { get set }
}

protocol ChatsInteractorProtocol {
    var networkManager : NetworkProtocol? { get set }
    var user: User? { get set }
    
    func loadMessages()
    func send(message: Message)
    func saveMessageToLocal(_ message: Message)
}

protocol ChatsInteractorOutputProtocol {
    var presentor : ChatsPresentor? { get set }
    
    func show(message: MessageViewModel)
    func loadConversation(with archieves: [MessageArchieveViewModel])
}
