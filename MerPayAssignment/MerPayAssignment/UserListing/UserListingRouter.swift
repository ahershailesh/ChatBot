//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class UserListingRouter : UserListingRouterProtocol {

    //MARK:- User listing.
    class func getUserListingController() -> UserListingController {
        let controller = UserListingController(nibName: nil, bundle: nil)
        let interactor = UserListingInteractor()
        let presenter = UserListingPresenter()
        let router = UserListingRouter()
        controller.presenter = presenter
        presenter.interactor = interactor
        presenter.view = controller
        presenter.router = router
        interactor.presenter = presenter
        return controller
    }
    
    //MARK:- Chat controller
    func pushChatController(over controller: UINavigationController, for model: HeaderViewModel) {
        let chatController = ChatsViewController(nibName: nil, bundle: nil)
        chatController.headerViewModel = model
        let chatBot = ChatBot()
        let interactor = ChatsInteractor(networkHandler: chatBot, userName: model.titleText!)
        let presenter = ChatsPresenter()
        let router = ChatsRouter()
        
        chatController.presenter = presenter
        presenter.interactor = interactor
        presenter.view = chatController
        presenter.router = router
        interactor.presenter = presenter
        chatBot.interactor = interactor
        
        chatController.presenter = presenter
        controller.pushViewController(chatController, animated: true)
    }
}
