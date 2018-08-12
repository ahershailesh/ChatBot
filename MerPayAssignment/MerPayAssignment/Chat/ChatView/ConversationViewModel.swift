//
//  ConversationViewModel.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class MessageArchieveViewModel {
    var dateString  :   String?
    var messages    :   [MessageViewModel] = []
}

class MessageViewModel {
    var time    :   String?
    var text    :   String?
    var type    :   MessageType = .sent
}

enum MessageType {
    case sent
    case recieved
}
