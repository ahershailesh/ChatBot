//
//  MessageEntity+CoreDataProperties.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import CoreData


// MARK: - MessageEntity
extension MessageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MessageEntity> {
        return NSFetchRequest<MessageEntity>(entityName: "MessageEntity")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var fromUserName: String?
    @NSManaged public var toUserName: String?

}
