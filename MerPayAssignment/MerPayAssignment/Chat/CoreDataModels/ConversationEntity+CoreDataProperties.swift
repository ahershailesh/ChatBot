//
//  ConversationEntity+CoreDataProperties.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import CoreData


// MARK: - ConversationEntity
extension ConversationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConversationEntity> {
        return NSFetchRequest<ConversationEntity>(entityName: "ConversationEntity")
    }

    @NSManaged public var fromUser: String?
    @NSManaged public var toUser: String?
    @NSManaged public var lastUpdate: NSDate?
    @NSManaged public var messageArchieves: NSSet?

}

// MARK: Generated accessors for messageArchieves
extension ConversationEntity {

    @objc(addMessageArchievesObject:)
    @NSManaged public func addToMessageArchieves(_ value: MessageArchieveEntity)

    @objc(removeMessageArchievesObject:)
    @NSManaged public func removeFromMessageArchieves(_ value: MessageArchieveEntity)

    @objc(addMessageArchieves:)
    @NSManaged public func addToMessageArchieves(_ values: NSSet)

    @objc(removeMessageArchieves:)
    @NSManaged public func removeFromMessageArchieves(_ values: NSSet)

}
