//
//  ChatBot.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

protocol ChatBotHandlerProtocol {
    func saveMessage(for userName: String)
    func getMessages(from userName: String) -> [MessagesModel]
}

class ChatBot: NetworkProtocol {
    private var user: User?
    
    init(user: User) {
        self.user = user
    }
    
    func get(url: String?, pathParam: [String]?, queryParam: [String : String]?, headers: [String : String]?, callBack: NetworkCallBack?) {
        let messages = getMessages(from: "saher")
        callBack?(true,  messages, nil)
    }
    
    func getData(from url: URL, callBack: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        callBack(nil, nil, nil)
    }
    
    func getHeaders(from url: URL, callBack: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        callBack(nil, nil, nil)
    }
    
    func post(url: String?, pathParam: [String]?, queryParam: [String : String]?, headers: [String : String]?, bodyString: String?, callBack: NetworkCallBack?) {
        //savedMessage(for: "saher")
        callBack?(true, nil, nil)
    }
}

extension ChatBot : ChatBotHandlerProtocol {
    
    func saveMessage(for userName: String) {
        print("Message saved")
    }
    
    func getMessages(from userName: String) -> [MessagesModel] {
        print("get message called")
        return []
    }
}
