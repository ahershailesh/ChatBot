//
//  ConversationViewModel.swift
//  ChatBot
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

/// View Model for the chat view controller.
/// This will combine messages of the day
class MessageArchieveViewModel {
    var dateString  :   String?
    var messages    :   [MessageViewModel] = []
}

// View model for a message
// Shows a message on the screen with specified type.
class MessageViewModel {
    var time    :   String?
    var text    :   String?
    var type    :   MessageType = .sent
}

// Desides what type of UI to show to user for a message.
enum MessageType {
    case sent
    case recieved
}
