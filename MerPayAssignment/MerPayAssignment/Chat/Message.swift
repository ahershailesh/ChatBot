//
//  Message.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

class Message: NSObject {
    var text    :   String?
    var date    :   Date?
    var type    :   MessageType = .sent
}
