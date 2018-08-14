//
//  MessageArchieveEntity+CoreDataClass.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MessageArchieveEntity)
public class MessageArchieveEntity: NSManagedObject {
    
    private var _messagesArray : [MessageEntity]? = nil
    
    var messagesArray : [MessageEntity] {
        _messagesArray = sort(entites: messages!)
        return _messagesArray!
    }
    
    private func sort(entites : NSSet) -> [MessageEntity] {
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        return (entites.sortedArray(using: [sortDescriptor]) as? [MessageEntity]) ?? []
    }
    
    func getMessageEntity(at index: Int) -> MessageEntity {
        return messagesArray[index]
    }
    
}
