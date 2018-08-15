//
//  ChatBot.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/12/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

/// This class will act as proxy over network
/// The API calls for the chats will be redirected to the chat bot and chat bot will reply to the sender.
class ChatBot: NetworkProtocol {
    var interactor : ChatsInteractorProtocol?
    
    func get(url: String?, pathParam: [String]?, queryParam: [String : String]?, headers: [String : String]?, callBack: NetworkCallBack?) {
        callBack?(true,  nil, nil)
    }
    
    func getData(from url: URL, callBack: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        callBack(nil, nil, nil)
    }
    
    func getHeaders(from url: URL, callBack: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        callBack(nil, nil, nil)
    }
    
    func post(url: String?, pathParam: [String]?, queryParam: [String : String]?, headers: [String : String]?, bodyString: String?, callBack: NetworkCallBack?) {
        callBack?(true, nil, nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let string = bodyString {
                self.sendReply(with:  string + " " + string)
            }
        }
    }
    
    private func sendReply(with text: String) {
        let message = Message()
        message.text = text
        message.type = .recieved
        message.date = Date()
        interactor?.saveMessageToLocal(message)
    }
}
