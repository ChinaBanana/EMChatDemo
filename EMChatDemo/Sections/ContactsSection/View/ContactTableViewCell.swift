//
//  ContactTableViewCell.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var contact:ContactItem?
    let avatarImage = UIImageView()
    let nameLabel = UILabel()
    let notifyDot = UIView.dot()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(notifyDot)
        
        avatarImage.frame = CGRect.init(x: LayoutLimit.margin_left, y: LayoutLimit.margin_top, width: 34, height: 34)
        avatarImage.layer.cornerRadius = 4
        avatarImage.clipsToBounds = true
        
        notifyDot.center = CGPoint.init(x: avatarImage.right, y: avatarImage.top)
        
        nameLabel.frame = CGRect.init(x: avatarImage.right + 8, y: avatarImage.top, width: 200, height: avatarImage.height)
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
        notifyDot.isHidden = true
        // Configure the view for the selected state
    }
    
    func configContent(_ model:ContactItem) -> () {
        contact = model
        nameLabel.text = model.name
        avatarImage.image = model.image
    }

}
