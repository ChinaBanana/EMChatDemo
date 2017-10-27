//
//  ConversationTableViewCell.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/20.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import RxSwift
import HyphenateLite

class ChatTableViewCell: UITableViewCell {

    let viewModel = ConversationTableViewCellVM()
    
    let avatarImage = UIImageView()
    let nameLabel = UILabel()
    let messageLabel = UILabel()
    let notifyLabel = UILabel.bage()
    let timeLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(notifyLabel)
        contentView.addSubview(timeLabel)
        
        avatarImage.frame = CGRect.init(x: Limit.margin_left, y: Limit.margin_top, width: 38, height: 38)
        avatarImage.layer.cornerRadius = 4
        avatarImage.clipsToBounds = true
        avatarImage.image = #imageLiteral(resourceName: "default_head")
        
        notifyLabel.center = CGPoint.init(x: avatarImage.right, y: avatarImage.top)
        
        nameLabel.frame = CGRect.init(x: avatarImage.right + 10, y: avatarImage.top, width: screen_width - avatarImage.right - 140, height: avatarImage.height / 2)
        nameLabel.font = UIFont.standard
        
        messageLabel.frame = CGRect.init(x: nameLabel.left, y: nameLabel.bottom, width: nameLabel.width, height: nameLabel.height)
        messageLabel.font = UIFont.small
        messageLabel.textColor = UIColor.init(white: 0.5, alpha: 0.5)
        
        timeLabel.frame = CGRect.init(x: nameLabel.right, y: nameLabel.top, width: 120, height: avatarImage.height)
        timeLabel.font = UIFont.small
        timeLabel.textColor = UIColor.init(white: 0.3, alpha: 0.5)
    }
    
    func configContent(_ conversation:EMConversation) -> () {
        viewModel.conversation = conversation
        nameLabel.text = conversation.conversationId
        configLatestMessage(conversation.latestMessage)
    }
    
    private func configLatestMessage(_ message:EMMessage) -> () {
        switch message.body.type {
        case EMMessageBodyTypeText:
            let textBody = message.body as! EMTextMessageBody
            messageLabel.text = textBody.text
        case EMMessageBodyTypeImage:
            messageLabel.text = "[图片]"
        default:
            break
        }
        timeLabel.text = timeOfTimeStamp(Double(message.timestamp))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
