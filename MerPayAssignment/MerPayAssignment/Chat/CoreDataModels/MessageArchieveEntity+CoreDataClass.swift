//
//  MessageArchieveEntity+CoreDataClass.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import CoreData

@objc(MessageArchieveEntity)
/// Message archieve is the conversation happened between a logged in user and the selected user in a day.
public class MessageArchieveEntity: NSManagedObject {
    
    //MARK:- Vars
    //MARK:- Private
    private var _messagesArray : [MessageEntity]? = nil
    
    //MARK:- Public
    var messagesArray : [MessageEntity] {
        _messagesArray = sort(entites: messages!)
        return _messagesArray!
    }
    
    //MARK:- Methods
    //MARK:- Private
    private func sort(entites : NSSet) -> [MessageEntity] {
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        return (entites.sortedArray(using: [sortDescriptor]) as? [MessageEntity]) ?? []
    }
    
    //MARK:- Public
    func getMessageEntity(at index: Int) -> MessageEntity {
        return messagesArray[index]
    }
    
}
