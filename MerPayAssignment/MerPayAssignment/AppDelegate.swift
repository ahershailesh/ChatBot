//
//  AppDelegate.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/9/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let userListingController = UserListingRouter.getUserListingController()
        let navController = UINavigationController(rootViewController: userListingController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}

