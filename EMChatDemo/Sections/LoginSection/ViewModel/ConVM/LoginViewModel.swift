//
//  LoginViewModel.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/20.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewModel: NSObject {
    
    let disposeBag = DisposeBag.init()
    
    override init() {
        super.init()
    }
    
    func register(_ account:String, password:String) -> () {
        EMChatService.shared.logInAccount(account, password: password)
    }
    
    func login(_ account:String, password:String) -> () {
        EMChatService.shared.logInAccount(account, password: password)
    }

}
