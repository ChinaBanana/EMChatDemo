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

class ConversationTableViewCell: UITableViewCell {

    let viewModel = ConversationTableViewCellVM()
    
    let avatarImage = UIImageView()
    let nameLabel = UILabel()
    let bubleImageView = UIImageView()
    let activityView = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
    
    var messageDetailView:UIView?
    
    lazy var textContent = TextContent()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bubleImageView)
        
        avatarImage.frame = CGRect.init(x: Limit.margin_left, y: Limit.margin_top, width: 38, height: 38)
        avatarImage.layer.cornerRadius = 4
        avatarImage.clipsToBounds = true
        avatarImage.image = #imageLiteral(resourceName: "default_head")
        
        nameLabel.font = UIFont.standard
        
    }
    
    func configContent(_ model:ConversationItem) -> () {
        
        messageDetailView?.removeFromSuperview()
        messageDetailView = nil
        
        if model.isSendByMe {
            bubleImageView.image = #imageLiteral(resourceName: "chat_sender_bg").stretchableImage(withLeftCapWidth: 5, topCapHeight: 35)
        }else{
            bubleImageView.image = #imageLiteral(resourceName: "chat_receiver_bg").stretchableImage(withLeftCapWidth: 35, topCapHeight: 35)
        }
        avatarImage.frame = model.avatarLayout.frame
        bubleImageView.frame = model.bubleLayout.frame
        
        switch model.messageBody.type {
        case EMMessageBodyTypeText:
            let textBody = model.messageBody as! EMTextMessageBody
            textContent.frame = model.contentLayout.frame
            textContent.text = textBody.text
            messageDetailView = textContent
        default:
            break
        }
        
        bubleImageView.addSubview(messageDetailView!)
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
