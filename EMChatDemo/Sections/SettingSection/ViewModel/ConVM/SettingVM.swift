//
//  SettingVM.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/20.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class SettingVM: NSObject {

    override init() {
        super.init()
    }
    
    func logOut() -> () {
        EMChatService.shared.logOut()
    }
}
