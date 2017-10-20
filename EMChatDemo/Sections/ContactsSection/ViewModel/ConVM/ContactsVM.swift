//
//  ContactsVM.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import RxSwift
import HyphenateLite

class ContactsVM: NSObject {
    
    enum RefreshUIType {
        case reloadSection1
    }
    
    let disposeBag = DisposeBag.init()
    let refreshSubject = PublishSubject<RefreshUIType>()
    
    private lazy var addFriendCon = AddFriendViewController()
    
    var section0 = [ContactItem.init("消息与通知", aImage:#imageLiteral(resourceName: "newFriends")),
                    ContactItem.init("群组", aImage:#imageLiteral(resourceName: "groupPrivateHeader")),
                    ContactItem.init("聊天室", aImage:#imageLiteral(resourceName: "groupPrivateHeader"))]
    var contacts = [ContactItem]()
    
    override init() {
        super.init()
        EMChatService.shared.contactSubject.subscribe { (event) in
            switch event {
            case .next(let element):
                switch element {
                case .addContact:
                    break
                case .allContacts(let contacts):
                    let items = contacts as! Array<String>
                    for item in items {
                        self.contacts.append(ContactItem.init(item, aImage:#imageLiteral(resourceName: "default_head")))
                        self.refreshSubject.onNext(.reloadSection1)
                    }
                }
            case .error(let error):
                debugPrint(error)
            case .completed:
                break
            }
        }.addDisposableTo(disposeBag)
        
        EMChatService.shared.getContacts()
    }

    func selectedIndex(_ index:IndexPath) -> () {
        switch index.section {
        case 0:
            break
        case 1:
            
            break
        default:
            break
        }
    }
    
    func addFriend() -> () {
        addFriendCon.hidesBottomBarWhenPushed = true
        NavigatarService.push(addFriendCon, animated: true)
    }
}
