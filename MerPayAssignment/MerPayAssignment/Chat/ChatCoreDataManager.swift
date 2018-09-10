//
//  ChatManager.swift
//  ChatBot
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import CoreData

/// This class will save and manage chats to the coredata.
class ChatCoreDataManager {
    
    //MARK:- Vars
    /// To apply a check on saving data
    /// This will avoid setting previous chat data in the app, To avoid any kind of intrusion.
    /// For mocking you can set any date in the Init.
    /// This will create issue if change of date happenes while application is alive. will need a fix.
    let currentDate : Date
    
    //MARK:- Initializations
    init(date : Date = Date() ) {
        currentDate = date
    }
    
    //MARK:- Public methods
    func getConversations(from userName: String) -> [ConversationEntity] {
        let context = CoreDataStack.shared.context
        let conversationRequest = NSFetchRequest<ConversationEntity>(entityName: "ConversationEntity")
        conversationRequest.predicate = NSPredicate(format: "fromUser = %@", argumentArray: [userName])
        let sortDescriptor = NSSortDescriptor(key: "lastUpdate", ascending: false)
        conversationRequest.sortDescriptors = [sortDescriptor]
        let objects = try? context.fetch(conversationRequest)
        return objects ?? []
    }
    
    func getConversation(fromUserName: String, toUserName : String) -> ConversationEntity {
        let context = CoreDataStack.shared.context
        let conversationRequest = NSFetchRequest<ConversationEntity>(entityName: "ConversationEntity")
        conversationRequest.predicate = NSPredicate(format: "fromUser = %@ AND toUser = %@", argumentArray: [fromUserName, toUserName])
        if let objects = try? context.fetch(conversationRequest), !objects.isEmpty {
            if objects.count != 1 {
                print("More than one conversations found to username = " + toUserName)
            }
            return objects.first!
        }
        let conversation = ConversationEntity(context: CoreDataStack.shared.context)
        conversation.fromUser = fromUserName
        conversation.toUser = toUserName
        return conversation
    }
    
    @discardableResult func save(message: Message, to conversation: ConversationEntity) -> MessageEntity? {
        if let date = message.date, Calendar.current.isDate(currentDate, inSameDayAs: date as Date) { print("Date is been changed, please check if intrusion happened.") }
        let messageEntity = MessageEntity(context: CoreDataStack.shared.context)
        messageEntity.text = message.text
        messageEntity.date = message.date! as NSDate
        
        var fromUserName = conversation.fromUser
        var toUserName = conversation.toUser
        if message.type == .recieved {
            fromUserName = conversation.toUser
            toUserName = conversation.fromUser
        }
        messageEntity.fromUserName = fromUserName
        messageEntity.toUserName = toUserName
        
        conversation.send(message: messageEntity)
        return messageEntity
    }
}
