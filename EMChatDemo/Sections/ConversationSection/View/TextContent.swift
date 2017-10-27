//
//  TextContent.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/23.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class TextContent: UILabel {

    init() {
        super.init(frame: .zero)
        font = UIFont.standard
        numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
