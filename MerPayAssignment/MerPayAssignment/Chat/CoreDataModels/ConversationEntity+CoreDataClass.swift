//
//  ConversationEntity+CoreDataClass.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ConversationEntity)
public class ConversationEntity: NSManagedObject {
    private var _messageArchieveArray : [MessageArchieveEntity]? = nil
    private var _currentArchieve : MessageArchieveEntity?
    var currentArchieve : MessageArchieveEntity {
        if _currentArchieve == nil {
            if let archieve = getCurrentArchive() {
                _currentArchieve = archieve
            } else {
                _currentArchieve = MessageArchieveEntity(context: CoreDataStack.shared.context)
                _currentArchieve?.messages = NSSet()
                _currentArchieve?.date = NSDate()
                _currentArchieve?.user = fromUser
                messageArchieves = messageArchieves?.adding(_currentArchieve!) as! NSSet
            }
        }
        return _currentArchieve!
    }
    
    var messageArchieveArray : [MessageArchieveEntity] {
        if _messageArchieveArray?.count !=  messageArchieves?.count {
            _messageArchieveArray = sort(entites: messageArchieves!)
        }
        return _messageArchieveArray!
    }
    
    private func sort(entites : NSSet) -> [MessageArchieveEntity] {
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        return (entites.sortedArray(using: [sortDescriptor]) as? [MessageArchieveEntity]) ?? []
    }
    
    func getMessageEntity(at index: Int) -> MessageArchieveEntity {
        return messageArchieveArray[index]
    }
    
    
    func getCurrentArchive() -> MessageArchieveEntity? {
        return messageArchieves?.first(where: { (obj) -> Bool in
            if let messageArchive = obj as? MessageArchieveEntity, let date = messageArchive.date {
                return Calendar.current.isDate(Date(), inSameDayAs: date as Date)
            }
            return false
        }) as? MessageArchieveEntity
    }
    
    func send(message: MessageEntity) {
        currentArchieve.addToMessages(message)
        CoreDataStack.shared.save()
    }
}
