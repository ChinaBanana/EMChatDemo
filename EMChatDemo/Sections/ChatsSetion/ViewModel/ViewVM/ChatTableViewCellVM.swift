//
//  ConversationTableViewCellVM.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/20.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import HyphenateLite
import RxSwift

class ChatTableViewCellVM: NSObject {

    var conversation:EMConversation?
    let disposeBag = DisposeBag.init()
    
    override init() {
        super.init()
        EMChatService.shared.messageSubject.subscribe { (event) in
            guard let element = event.element else {
                return
            }
            switch element {
            case .receiveNewMessage(let aMessage):
                guard aMessage.conversationId == self.conversation?.conversationId else {
                    return
                }
            default:
                break
            }
        }.addDisposableTo(disposeBag)
    }
}
