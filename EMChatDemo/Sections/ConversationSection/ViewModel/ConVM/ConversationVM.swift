//
//  ConversationVM.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import RxSwift
import HyphenateLite

class ConversationVM: NSObject {
    
    enum RefreshUIType {
        case reloadTableView
        case reloadIndexPath(IndexPath)
        case receiveNewMessage
        case title
    }
    
    private var currentConversation:EMConversation?

    var conversation:EMConversation? {
        set {
            guard newValue?.conversationId != currentConversation?.conversationId else {
                return
            }
            currentConversation = newValue
            loadHistoryMessages()
        }
        get {
            return currentConversation
        }
    }
    
    let disposeBag = DisposeBag.init()
    let refreshUISubject = PublishSubject<RefreshUIType>()
    
    var messages = [ConversationItem]()
    var isChatting:Bool = false
    
    override init() {
        super.init()
        EMChatService.shared.conversationSubject.subscribe { (event) in
            if let element = event.element {
                switch element {
                case .allConversations(_):
                    break
                case .newConversation(let conversation):
                    guard conversation.conversationId != self.currentConversation?.conversationId else {
                        return
                    }
                    self.conversation = conversation
                }
            }
        }.addDisposableTo(disposeBag)
        
        EMChatService.shared.messageSubject.subscribe { (event) in
            if let element = event.element {
                switch element {
                case .receiveNewMessage(let message):
                    guard message.conversationId == self.currentConversation?.conversationId else{
                        return
                    }
                    self.messages.append(ConversationItem.init(message))
                    self.refreshUISubject.onNext(.receiveNewMessage)
                case .sendANewMessage(let message):
                    guard message.conversationId == self.currentConversation?.conversationId else{
                        return
                    }
                }
            }
        }.addDisposableTo(disposeBag)
    }
    
    func sendTextMessage(_ text:String) -> () {
        let textbody = EMTextMessageBody.init(text: text)
        let message = EMMessage.init(conversationID: currentConversation!.conversationId, from: EMClient.shared().currentUsername, to: currentConversation!.conversationId, body: textbody, ext: nil)
        messages.append(ConversationItem.init(message!))
        let index = messages.count - 1
        self.refreshUISubject.onNext(.receiveNewMessage)
        EMChatService.shared.sendMessage(message!, progress: { (aProgress) in
            
        }) { (aMessage) in
            self.messages.remove(at: index)
            self.messages.append(ConversationItem.init(aMessage))
            self.refreshUISubject.onNext(.reloadIndexPath(IndexPath.init(item: index, section: 0)))
        }
    }
    
    func loadHistoryMessages() -> () {
        messages.removeAll()
        refreshUISubject.onNext(.title)
        refreshUISubject.onNext(.reloadTableView)
        guard currentConversation?.latestMessage != nil else{
            return
        }
        self.currentConversation?.loadMessagesStart(fromId: currentConversation!.latestMessage.messageId, count: 10, searchDirection: EMMessageSearchDirectionUp, completion: { (aMessages, aError) in
            guard aError == nil, aMessages != nil else {
                return
            }
            for message in aMessages as! Array<EMMessage> {
                self.messages.append(ConversationItem.init(message))
            }
            self.refreshUISubject.onNext(.reloadTableView)
        })
    }
}
