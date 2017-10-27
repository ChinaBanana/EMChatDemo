//
//  SystemNotifyVM.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/24.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import RxSwift

class SystemNotifyVM: NSObject {
    
    enum RefeshUItype {
        case reloadTableVeiw
    }
    
    var requests = [String]()
    let disposeBag = DisposeBag.init()
    let refreshUISubject = PublishSubject<RefeshUItype>()

    override init() {
        super.init()
        
        EMChatService.shared.contactSubject.subscribe { (event) in
            guard let element = event.element else {
                return
            }
            switch element {
            case .receiveRequest(let aUserName):
                self.requests.append(aUserName)
                self.refreshUISubject.onNext(.reloadTableVeiw)
            case .acceptRequestSucceed(let username), .declineRequestSucceed(let username):
                for (index, item) in self.requests.enumerated() {
                    if item == username {
                        self.requests.remove(at: index)
                        self.refreshUISubject.onNext(.reloadTableVeiw)
                        break
                    }
                }
            default:
                break
            }
        }.addDisposableTo(disposeBag)
    }
}
