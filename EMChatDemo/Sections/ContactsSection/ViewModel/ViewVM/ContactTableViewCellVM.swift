//
//  ContactTableViewCellVM.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/27.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//


import UIKit
import RxSwift

class ContactTableViewCellVM: NSObject {

    enum RefreshUIType {
        case showDot(Bool)
    }
    
    let disposeBag = DisposeBag()
    let refreshUISubject = PublishSubject<RefreshUIType>()
    var contactItem:ContactItem?
    
    override init() {
        super.init()
        
        EMChatService.shared.contactSubject.subscribe { (event) in
            guard let element = event.element else{
                return
            }
            switch element {
            case .receiveRequest(_):
                self.refreshUISubject.onNext(.showDot(true))
            default:
                break
            }
        }.addDisposableTo(disposeBag)
    }
    
    
}
