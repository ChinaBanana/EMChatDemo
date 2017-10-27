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
    
    let disposeBag = DisposeBag.init()
    let clientSubject = PublishSubject<ClientEvent>()
    let messageSubject = PublishSubject<MessageEvent>()
    let conversationSubject = PublishSubject<ConversationEvent>()
    let contactSubject = PublishSubject<ContactEvent>()
    
    override init() {
        super.init()
        EMClient.shared().add(self, delegateQueue: DispatchQueue.main)
        debugPrint(EMClient.shared())
        debugPrint(EMClient.shared().chatManager)
        
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
    
    enum ClientEvent {
        case register(Bool)
        case login(Bool)
        case logOut(Bool)
    }
    
    func register(_ username:String, password:String) -> () {
        EMClient.shared().register(withUsername: username, password: password) { (aMessage, aError) in
            guard aError == nil else {
                debugPrint("Register Error:\(aError!.errorDescription)")
                return
            }
            self.clientSubject.onNext(.register(true))
        }
    }
    
    func logInAccount(_ username:String, password:String) -> () {
        EMClient.shared().login(withUsername: username, password: password) { (message, aError) in
            guard aError == nil else {
                debugPrint("Login Error:\(aError!.errorDescription)")
                return
            }
            let option = EMClient.shared().options
            option?.isAutoLogin = true
            self.clientSubject.onNext(.login(true))
        }
    }
    
    func logOut() -> () {
        EMClient.shared().logout(true) { (aError) in
            guard aError == nil else {
                debugPrint("logout error:\(aError!.errorDescription)")
                return
            }
            self.clientSubject.onNext(.logOut(true))
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
    
    enum MessageEvent {
        case receiveNewMessage(EMMessage)
        case sendANewMessage(EMMessage)
    }
    
    enum ConversationEvent {
        case allConversations(Array<EMConversation>)
        case newConversation(EMConversation)
    }
    
    func newConversation(_ conversationId:String, type:EMConversationType) -> () {
        let newConversation = EMClient.shared().chatManager.getConversation(conversationId, type:type , createIfNotExist: true)
        conversationSubject.onNext(.newConversation(newConversation!))
    }
    
    func getConversations() -> () {
        conversationSubject.onNext(.allConversations(EMClient.shared().chatManager.getAllConversations() as! Array<EMConversation>))
    }
    
    func deleteConversation(_ conversationID:String) -> () {
        EMClient.shared().chatManager.deleteConversation(conversationID, isDeleteMessages: true) { (aMessage, aError) in
            guard aError == nil else {
                debugPrint("delete conversation Error:\(aError!.errorDescription)")
                return
            }
        }
    }
    
    func sendMessage(_ message:EMMessage, progress:@escaping(Int32) -> (), result:@escaping(EMMessage) -> ()) -> () {
        EMClient.shared().chatManager.send(message, progress: { (aProgress) in
            progress(aProgress)
        }) { (aMessage, aError) in
            guard aError == nil, aMessage != nil else {
                debugPrint(aError!.errorDescription)
                return
            }
            result(aMessage!)
            self.messageSubject.onNext(.sendANewMessage(aMessage!))
        }
    }
    
    func messagesDidReceive(_ aMessages: [Any]!) {
        
    }
    
    func cmdMessagesDidReceive(_ aCmdMessages: [Any]!) {
        
    }
    
    func messageStatusDidChange(_ aMessage: EMMessage!, error aError: EMError!) {
        
    }
}

extension EMChatService : EMContactManagerDelegate {
    
    enum ContactEvent {
        case addContact
        case allContacts(Array<Any>)
        case receiveRequest(String)
        case acceptRequestSucceed(String)
        case declineRequestSucceed(String)
    }
    
    func getContacts() -> () {
        EMClient.shared().contactManager.getContactsFromServer { (contacts, aError) in
            guard aError == nil, contacts != nil else{
                return
            }
            self.contactSubject.onNext(.allContacts(contacts!))
        }
    }
    
    func addFriend(_ username:String) -> () {
        EMClient.shared().contactManager.addContact(username, message: "Add me as a friend") { (message, aError) in
            guard aError == nil else {
                debugPrint("Add contact error:\(aError!.errorDescription)")
                return
            }
            debugPrint("Add request has been send")
        }
    }
    
    func acceptFriendRequest(_ username:String) -> () {
        let error = EMClient.shared().contactManager.acceptInvitation(forUsername: username)
        guard error == nil else {
            return
        }
        contactSubject.onNext(.acceptRequestSucceed(username))
    }
    
    func declineFriendRequest(_ username:String) -> () {
        let error = EMClient.shared().contactManager.declineInvitation(forUsername: username)
        guard error == nil else {
            return
        }
        contactSubject.onNext(.declineRequestSucceed(username))
    }
    
    func deleteFriend(_ username:String) -> () {
        EMClient.shared().contactManager.deleteContact(username, isDeleteConversation: true)
    }
    
    // 旁友接收了我的好友请求
    func friendRequestDidApprove(byUser aUsername: String!) {
        
    }
    
    // 旁友拒绝了我的好友请求
    func friendRequestDidDecline(byUser aUsername: String!) {
        
    }
    
    // 收到了旁友的好友请求
    func friendRequestDidReceive(fromUser aUsername: String!, message aMessage: String!) {
        contactSubject.onNext(.receiveRequest(aUsername))
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
