//
//  ChatManager.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import CoreData

class ChatCoreDataManager {
    
    let currentDate : Date
    
    init(date : Date = Date() ) {
        currentDate = date
    }
    
    func getConversation(fromUserName: String, toUserName : String) -> ConversationEntity {
        let context = CoreDataStack.shared.context
        let conversationRequest = NSFetchRequest<ConversationEntity>(entityName: "ConversationEntity")
        conversationRequest.predicate = NSPredicate(format: "toUser = %@", argumentArray: [toUserName])
        if let objects = try? context.fetch(conversationRequest), !objects.isEmpty {
            if objects.count != 1 {
                print("More than one conversations found to username = " + toUserName)
            }
            return objects.first!
        }
        let conversation = ConversationEntity(context: CoreDataStack.shared.context)
        conversation.fromUser = fromUserName
        conversation.toUser = toUserName
        CoreDataStack.shared.save()
        return conversation
    }
    
    @discardableResult func save(message: Message, to conversation: ConversationEntity) -> MessageEntity? {
        guard let date = message.date, Calendar.current.isDate(currentDate, inSameDayAs: date as Date) else { return nil }
        let messageEntity = MessageEntity(context: CoreDataStack.shared.context)
        messageEntity.text = message.text
        messageEntity.date = message.date as! NSDate
        messageEntity.fromUserName = conversation.fromUser
        messageEntity.toUserName = conversation.toUser
        conversation.send(message: messageEntity)
        return messageEntity
    }
}
