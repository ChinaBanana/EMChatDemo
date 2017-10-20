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
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLabel)
        
        avatarImage.frame = CGRect.init(x: LayoutLimit.margin_left, y: LayoutLimit.margin_top, width: 38, height: 38)
        avatarImage.layer.cornerRadius = 4
        avatarImage.clipsToBounds = true
        avatarImage.image = #imageLiteral(resourceName: "default_head")
        
        nameLabel.frame = CGRect.init(x: avatarImage.right + 10, y: avatarImage.top, width: screen_width - avatarImage.right - 140, height: avatarImage.height / 2)
        nameLabel.font = UIFont.standard
        
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
