//
//  NavigatarService.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class NavigatarService: NSObject, UINavigationControllerDelegate {

    static let shared = NavigatarService()
    static let conversationCon = ConversationViewController()
    static var isChatting:Bool = false
    
    class func push(_ viewCon:UIViewController, animated:Bool) {
        let rootCon = UIApplication.shared.keyWindow?.rootViewController
        if let tabbarCon = rootCon as? UITabBarController {
            if let currentCon = tabbarCon.selectedViewController as? UINavigationController {
                currentCon.pushViewController(viewCon, animated: animated)
            }
        }else if let naviCon = rootCon as? UINavigationController {
            naviCon.pushViewController(viewCon, animated: animated)
        }
    }
    
    class func pop(_ animated:Bool) {
        let rootCon = UIApplication.shared.keyWindow?.rootViewController
        if let tabbarCon = rootCon as? UITabBarController {
            if let currentCon = tabbarCon.selectedViewController as? UINavigationController {
                currentCon.popViewController(animated: animated)
            }
        }else if let naviCon = rootCon as? UINavigationController {
            naviCon.popViewController(animated: animated)
        }
    }
    
    class func pushToConversation() {
        push(conversationCon, animated: true)
    }
    
    // MARK: UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop && fromVC.isKind(of: ConversationViewController.self) {
            NavigatarService.isChatting = false
        }
        return nil
    }
    
}
