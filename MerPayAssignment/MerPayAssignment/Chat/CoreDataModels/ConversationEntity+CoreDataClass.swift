//
//  ConversationEntity+CoreDataClass.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import CoreData

@objc(ConversationEntity)
/// A conversation between in LoggedInUser and selected use.
/// This class will consist of the messages archieves
// A conversationEntity is all the conversation happened between a logged in user and the selected user.

public class ConversationEntity: NSManagedObject {
    
    //MARK:- Vars
    //MARK:- Private
    /// this array stores sorted message archieves.
    private var _messageArchieveArray : [MessageArchieveEntity]? = nil
    private var _currentArchieve : MessageArchieveEntity?
    
    //MARK:- Public
    var currentArchieve : MessageArchieveEntity {
        if _currentArchieve == nil {
            if let archieve = getCurrentArchive() {
                _currentArchieve = archieve
            } else {
                _currentArchieve = MessageArchieveEntity(context: CoreDataStack.shared.context)
                _currentArchieve?.messages = NSSet()
                _currentArchieve?.date = NSDate()
                _currentArchieve?.user = fromUser
                messageArchieves = messageArchieves?.adding(_currentArchieve!) as NSSet?
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
    
    //MARK:- Methods
    //MARK:- Private
    private func sort(entites : NSSet) -> [MessageArchieveEntity] {
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        return (entites.sortedArray(using: [sortDescriptor]) as? [MessageArchieveEntity]) ?? []
    }
    
    //MARK:- Public
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
        self.lastUpdate = NSDate()
    }
}
