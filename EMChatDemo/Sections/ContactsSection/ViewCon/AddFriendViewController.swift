//
//  AddFriendViewController.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    let searchCon = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11, *) {
            navigationItem.searchController = searchCon
        }else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
