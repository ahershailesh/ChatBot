//
//  MessageArchieveEntity+CoreDataProperties.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import CoreData


// MARK: - MessageArchieveEntity
extension MessageArchieveEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MessageArchieveEntity> {
        return NSFetchRequest<MessageArchieveEntity>(entityName: "MessageArchieveEntity")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var user: String?
    @NSManaged public var messages: NSSet?

}

// MARK: Generated accessors for messages
extension MessageArchieveEntity {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: MessageEntity)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: MessageEntity)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}
