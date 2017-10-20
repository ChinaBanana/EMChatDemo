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

class ChatVM: NSObject {
    
    enum RefreshUIType {
        case reloadTableView
    }

    let disposeBag = DisposeBag.init()
    let refreshUISubject = PublishSubject<RefreshUIType>()
    
    var isChatting:Bool = false
    var conversations = [EMConversation]()
    
    override init() {
        super.init()
        EMChatService.shared.conversationSubject.subscribe { (event) in
            if let element = event.element {
                switch element {
                case .allConversations(let conversations):
                    self.conversations.append(contentsOf: conversations)
                    self.refreshUISubject.onNext(.reloadTableView)
                case .newConversation(_):
                    break
                }
            }
        }.addDisposableTo(disposeBag)
        
        EMChatService.shared.getConversations()
    }
}
