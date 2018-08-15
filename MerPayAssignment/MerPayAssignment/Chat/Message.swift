//
//  Message.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

/// Entity model to be passed among the functions.
/// This will be a mediator between MessageViewModel(View Model) and the MessageEntity(Core Data Model)
class Message: NSObject {
    var text    :   String?
    var date    :   Date?
    var type    :   MessageType = .sent
}
