//
//  MessagesModel.swift
//  ChatBot
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation


/// Entity model to be passed among the functions.
/// Core data entity for the model is MessageArchieveEntity
class MessagesModel: NSObject {
    var date : Date?
    var messages : [Message] = []
    var user: String?
}
