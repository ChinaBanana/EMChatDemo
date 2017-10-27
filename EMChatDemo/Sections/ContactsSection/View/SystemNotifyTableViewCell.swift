//
//  SystemNotifyTableViewCell.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/26.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class SystemNotifyTableViewCell: UITableViewCell {
    
    let avatarImage = UIImageView.init(image: #imageLiteral(resourceName: "default_head"))
    let nameLabel = UILabel()
    let acceptBtn = UIButton()
    let declineBtn = UIButton()
    
    var request:String!

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(acceptBtn)
        contentView.addSubview(declineBtn)
        
        avatarImage.frame = CGRect.init(x: Limit.margin_left, y: Limit.margin_top, width: 34, height: 34)
        avatarImage.layer.cornerRadius = 4
        avatarImage.clipsToBounds = true
        
        nameLabel.frame = CGRect.init(x: avatarImage.right + 10, y: 0, width: 100, height: 50)
        nameLabel.numberOfLines = 0
        
        acceptBtn.frame = CGRect.init(x: screen_width - 200, y: 10, width: 80, height: 30)
        acceptBtn.backgroundColor = .main
        acceptBtn.setTitle("Accept", for: .normal)
        acceptBtn.addTarget(self, action: #selector(acceptBtnClicked), for: .touchUpInside)
        
        declineBtn.frame = CGRect.init(x: acceptBtn.right + 10, y: acceptBtn.top, width: acceptBtn.width, height: acceptBtn.height)
        declineBtn.backgroundColor = .red
        declineBtn.setTitle("Decline", for: .normal)
        declineBtn.addTarget(self, action: #selector(declineBtnClicked), for: .touchUpInside)
    }
    
    func configCell(_ request:String) -> () {
        self.request = request
        nameLabel.text = request
    }
    
    @objc func acceptBtnClicked() {
        EMChatService.shared.acceptFriendRequest(request)
    }
    
    @objc func declineBtnClicked() {
        EMChatService.shared.declineFriendRequest(request)
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
