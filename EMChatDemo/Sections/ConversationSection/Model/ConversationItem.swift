//
//  ConversationItem.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/23.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import HyphenateLite

struct ConversationItem {
    
    let message:EMMessage
    let messageBody:EMMessageBody
    let isSendByMe:Bool
    
    var nameLayout:Layout = Layout()
    var avatarLayout:Layout = Layout()
    var bubleLayout:Layout = Layout()
    var contentLayout:Layout = Layout()
    
    var height:CGFloat {
        get {
            return bubleLayout.bottom
        }
    }
    
    init(_ aMessage:EMMessage) {
        message = aMessage
        messageBody = aMessage.body
        isSendByMe = message.direction == EMMessageDirectionSend
        
//        if message.chatType != EMChatTypeChat {
//            nameLayout.size = CGSize.init(width: 200, height: 20)
//            nameLayout.top = Limit.margin_top
//        }
        avatarLayout.size = CGSize.init(width: 34, height: 34)
        
        if isSendByMe {
            configMyMessage()
        } else {
            configReceivedMessage()
        }
    }
    
    private mutating func configMyMessage() -> () {
        avatarLayout.origin = CGPoint.init(x: screen_width - 54, y: Limit.margin_top)
        
        switch messageBody.type {
        case EMMessageBodyTypeText:
            let textBody = messageBody as! EMTextMessageBody
            contentLayout.size = textBody.text.sizeWithLimit(CGSize.init(width: screen_width - 180, height: CGFloat.infinity), font: UIFont.standard)
            contentLayout.left = 8
            contentLayout.top = Limit.margin_top
            
            bubleLayout.size = CGSize.init(width: contentLayout.width + 20, height: contentLayout.height + 20)
            bubleLayout.right = avatarLayout.left - 5
            bubleLayout.top = avatarLayout.top
        default:
            break
        }
    }
    
    private mutating func configReceivedMessage() -> () {
        avatarLayout.origin = CGPoint.init(x: Limit.margin_left, y: Limit.margin_top)
        
        switch messageBody.type {
        case EMMessageBodyTypeText:
            let textBody = messageBody as! EMTextMessageBody
            contentLayout.size = textBody.text.sizeWithLimit(CGSize.init(width: screen_width - 180, height: CGFloat.infinity), font: UIFont.standard)
            contentLayout.left = 8
            contentLayout.top = Limit.margin_top
            
            bubleLayout.size = CGSize.init(width: contentLayout.width + 20, height: contentLayout.height + 20)
            bubleLayout.left = avatarLayout.right + 5
            bubleLayout.top = avatarLayout.top
            
        default:
            break
        }
    }
}
