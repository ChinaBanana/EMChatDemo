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
    
    private lazy var groupCon = GroupViewController()
    private lazy var systemNotifyCon = SystemNotifyViewController()
    private lazy var addFriendCon = AddFriendViewController()
    
    let section0 = [ContactItem.init("消息与通知", aImage:#imageLiteral(resourceName: "newFriends")),
                    ContactItem.init("群组", aImage:#imageLiteral(resourceName: "groupPrivateHeader")),
                    ContactItem.init("聊天室", aImage:#imageLiteral(resourceName: "groupPrivateHeader"))]
    var contacts = [ContactItem]()
    
    override init() {
        super.init()
        EMChatService.shared.contactSubject.subscribe { (event) in
            
            guard let element = event.element else {
                return
            }
            switch element {
            case .addContact:
                break
            case .allContacts(let contacts):
                let items = contacts as! Array<String>
                for item in items {
                    self.contacts.append(ContactItem.init(item, aImage:#imageLiteral(resourceName: "default_head")))
                    self.refreshSubject.onNext(.reloadSection1)
                }
            default:
                break
            }
        }.addDisposableTo(disposeBag)
        
        EMChatService.shared.getContacts()
    }

    func selectedIndex(_ index:IndexPath) -> () {
        switch index.section {
        case 0:
            switch index.row {
            case 0:
                NavigatarService.push(systemNotifyCon, animated: true)
            case 1:
                break
            default:
                break
            }
            break
        case 1:
            NavigatarService.pushToConversation()
            EMChatService.shared.newConversation(contacts[index.row].name, type:EMConversationTypeChat)
        default:
            break
        }
    }
    
    func addFriend() -> () {
        addFriendCon.hidesBottomBarWhenPushed = true
        NavigatarService.push(addFriendCon, animated: true)
    }
}
