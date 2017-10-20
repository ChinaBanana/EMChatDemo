//
//  AppDelegate.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import HyphenateLite

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var sharedDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    lazy var logInCon:UINavigationController = {
        return UINavigationController.init(rootViewController: LoginViewController())
    }()
    
    lazy var mainCon:MainViewController = {
        return MainViewController()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        configApperance()
        configEMClient()
        return true
    }
    
    func configApperance() -> () {
        UITabBar.appearance().barTintColor = .main
        
        UINavigationBar.appearance().barTintColor = .main
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func configEMClient() -> () {
        let options = EMOptions.init(appkey: "zhaohwem#cocoaleeochatdemo")
        EMClient.shared().initializeSDK(with: options)
        
        EMChatService.shared.clientSubject.subscribe { (event) in
            switch event {
            case .next(let element):
                switch element {
                case .login(let succeed):
                    if succeed {
                        self.transformWindow(self.mainCon)
                    }
                case .logOut(let succeed):
                    if succeed {
                        self.transformWindow(self.logInCon)
                    }
                default:
                    break
                }
            case .error(let error):
                debugPrint("Appdelegate Error:\(error)")
            case .completed:
                debugPrint("Completed")
            }
        }.addDisposableTo(EMChatService.shared.disposeBag)
        
        debugPrint("Has logedin \(EMClient.shared().isLoggedIn), auto login \(EMClient.shared().isAutoLogin)")
        
        if EMClient.shared().isLoggedIn {
            debugPrint(EMClient.shared().currentUsername)
            window?.rootViewController = mainCon
        }else {
            window?.rootViewController = logInCon
        }
        window?.makeKeyAndVisible()
    }
    
    func transformWindow(_ viewCon:UIViewController) -> () {
        UIView.transition(with: viewCon.view, duration: 0.35, options: UIViewAnimationOptions.transitionFlipFromBottom, animations: {
            self.window?.rootViewController = viewCon
        }) { (completion) in
            
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

