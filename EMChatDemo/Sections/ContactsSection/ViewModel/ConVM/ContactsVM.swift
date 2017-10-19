//
//  ContactsVM.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class ContactsVM: NSObject {
    
    var section0 = [ContactItem(),
                    ContactItem(),
                    ContactItem()]
    var contacts = [ContactItem]()
    
    override init() {
        super.init()
    }

    func selectedIndex(_ index:IndexPath) -> () {
        
    }
}
