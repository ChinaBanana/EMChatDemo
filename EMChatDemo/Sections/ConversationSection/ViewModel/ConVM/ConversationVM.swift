//
//  ConversationVM.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import RxSwift
import HyphenateLite

class ConversationVM: NSObject {
    
    enum RefreshUIType {
        case reloadTableView
    }

    let disposeBag = DisposeBag.init()
    let refreshUISubject = PublishSubject<RefreshUIType>()
    
    var isChatting:Bool = false
    
    override init() {
        super.init()
        
    }
}
