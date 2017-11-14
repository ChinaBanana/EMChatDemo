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
    
    var imageSize:CGSize = CGSize.init(width: 1, height: 1)
    var nameLayout:Layout = Layout()
    var avatarLayout:Layout = Layout()
    var bubleLayout:Layout = Layout()
    var contentLayout:Layout = Layout()
    
    var height:CGFloat {
        get {
            return bubleLayout.bottom
        }
    }
    
    init(_ aMessage:EMMessage, aImageSize:CGSize) {
        imageSize = aImageSize
        message = aMessage
        messageBody = aMessage.body
        isSendByMe = message.direction == EMMessageDirectionSend
        avatarLayout.size = CGSize.init(width: 34, height: 34)
        if isSendByMe {
            configMyMessage()
        } else {
            configReceivedMessage()
        }
    }
    
    init(_ aMessage:EMMessage) {
        message = aMessage
        messageBody = aMessage.body
        isSendByMe = message.direction == EMMessageDirectionSend
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
        case EMMessageBodyTypeImage:
            configImagelayout()
            contentLayout.top = 2
            contentLayout.left = 2
            bubleLayout.size = CGSize.init(width: contentLayout.width + 10, height: contentLayout.height + 4)
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
        case EMMessageBodyTypeImage:
            configImagelayout()
            contentLayout.left = 8
            bubleLayout.size = CGSize.init(width: contentLayout.width + 10, height: contentLayout.height + 4)
            bubleLayout.left = avatarLayout.right + 5
            bubleLayout.top = avatarLayout.top
        default:
            break
        }
    }
    
    mutating func configImagelayout() {
        guard let imageBody = messageBody as? EMImageMessageBody else {
            return
        }
        if imageBody.size != CGSize.zero {
            if imageBody.size.width > imageBody.size.height {
                contentLayout.width = Limit.thumbImage
                contentLayout.height = Limit.thumbImage * imageBody.size.height / imageBody.size.width
            }  else {
                contentLayout.height = Limit.thumbImage
                contentLayout.width = Limit.thumbImage * imageBody.size.width / imageBody.size.height
            }
        }else{
            if imageSize.width > imageSize.height {
                contentLayout.width = Limit.thumbImage
                contentLayout.height = Limit.thumbImage * imageSize.height / imageSize.width
            }else {
                contentLayout.height = Limit.thumbImage
                contentLayout.width = Limit.thumbImage * imageSize.width / imageSize.height
            }
        }
    }
}
