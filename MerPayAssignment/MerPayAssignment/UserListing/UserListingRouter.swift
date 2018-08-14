//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class UserListingRouter : UserListingRouterProtocol {

    class func getUserListingController() -> UserListingController {
        let controller = UserListingController(nibName: nil, bundle: nil)
        let interactor = UserListingInteractor()
        let presentor = UserListingPresentor()
        let router = UserListingRouter()
        controller.presentor = presentor
        presentor.interactor = interactor
        presentor.view = controller
        presentor.router = router
        interactor.presentor = presentor
        return controller
    }
    
    func pushChatController(over controller: UINavigationController, for model: HeaderViewModel) {
        let chatController = ChatsViewController(nibName: nil, bundle: nil)
        chatController.headerViewModel = model
        let chatBot = ChatBot()
        let interactor = ChatsInteractor(networkHandler: chatBot, userName: model.titleText!)
        let presentor = ChatsPresentor()
        let router = ChatsRouter()
        
        chatController.presentor = presentor
        presentor.interactor = interactor
        presentor.view = chatController
        presentor.router = router
        interactor.presentor = presentor
        chatBot.interactor = interactor
        
        chatController.presentor = presentor
        controller.pushViewController(chatController, animated: true)
    }
}
