//
//  EMChatService.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import HyphenateLite
import RxSwift

class EMChatService: NSObject {

    static let shared = EMChatService()
    
    let clientSubject = PublishSubject<ClientEvent>()
    let messageSubject = PublishSubject<MessageEvent>()
    let conversationSubject = PublishSubject<ConversationEvent>()
    let contactSubject = PublishSubject<ContactEvent>()
    
    enum ClientEvent {
        case logIn(Bool)
        case logOut(Bool)
    }
    
    enum ContactEvent {
        case addContact
    }
    
    enum MessageEvent {
        case receiveNewMessage(EMMessage)
        case sendANewMessage(EMMessage)
    }
    
    enum ConversationEvent {
        case newConversation(EMConversation)
    }
    
    override init() {
        super.init()
        EMClient.shared().add(self, delegateQueue: DispatchQueue.main)
        EMClient.shared().chatManager.add(self, delegateQueue: DispatchQueue.main)
        EMClient.shared().contactManager.add(self, delegateQueue: DispatchQueue.main)
        EMClient.shared().roomManager.add(self, delegateQueue: DispatchQueue.main)
        EMClient.shared().groupManager.add(self, delegateQueue: DispatchQueue.main)
    }
    
    deinit {
        EMClient.shared().removeDelegate(self)
        EMClient.shared().chatManager.remove(self)
        EMClient.shared().contactManager.removeDelegate(self)
        EMClient.shared().roomManager.remove(self)
        EMClient.shared().groupManager.removeDelegate(self)
    }
}

extension EMChatService {
    
    func logInAccount(_ username:String, password:String) -> () {
        EMClient.shared().login(withUsername: username, password: password) { (message, aError) in
            guard aError == nil else {
                debugPrint("Login Error:\(aError!.errorDescription)")
                return
            }
            let option = EMClient.shared().options
            option?.isAutoLogin = true
        }
    }
    
    func logOut() -> () {
        EMClient.shared().logout(true) { (aError) in
            guard aError == nil else {
                debugPrint("logout error:\(aError!.errorDescription)")
                return
            }
            
        }
    }
}

extension EMChatService : EMClientDelegate {
    
    // 网络联接状态
    func connectionStateDidChange(_ aConnectionState: EMConnectionState) {
        
    }
    
    // 自动登录
    func autoLoginDidCompleteWithError(_ aError: EMError!) {
        
    }
    
    // 被挤掉了
    func userAccountDidLoginFromOtherDevice() {
        
    }
}

extension EMChatService : EMChatManagerDelegate {
    
    func messagesDidReceive(_ aMessages: [Any]!) {
        
    }
    
    func cmdMessagesDidReceive(_ aCmdMessages: [Any]!) {
        
    }
    
    func messageStatusDidChange(_ aMessage: EMMessage!, error aError: EMError!) {
        
    }
}

extension EMChatService : EMContactManagerDelegate {
    
    // 旁友接收了我的好友请求
    func friendRequestDidApprove(byUser aUsername: String!) {
        
    }
    
    // 旁友拒绝了我的好友请求
    func friendRequestDidDecline(byUser aUsername: String!) {
        
    }
    
    // 收到了旁友的好友请求
    func friendRequestDidReceive(fromUser aUsername: String!, message aMessage: String!) {
        
    }
    
    func friendshipDidAdd(byUser aUsername: String!) {
        
    }
    
    func friendshipDidRemove(byUser aUsername: String!) {
        
    }
    
}

extension EMChatService : EMGroupManagerDelegate {
    
}

extension EMChatService : EMChatroomManagerDelegate {
    
}
