//
//  MainViewController.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let title = "title"
        let icon = "icon"
        let selected_icon = "selected_icon"
        let con_name = "con_name"
        let viewConDetails:Array<Dictionary<String,Any>> = [
            [
                title:"会话",
                con_name:ChatViewController(),
                icon:#imageLiteral(resourceName: "tabbar_chat").withRenderingMode(.alwaysOriginal),
                selected_icon: #imageLiteral(resourceName: "tabbar_chat_selected").withRenderingMode(.alwaysOriginal)
            ],
            [
                title:"联系人",
                con_name:ContactsViewController(),
                icon:#imageLiteral(resourceName: "tabbar_contact").withRenderingMode(.alwaysOriginal),
                selected_icon: #imageLiteral(resourceName: "tabbar_contact_selected").withRenderingMode(.alwaysOriginal)
            ],
            [
                title:"设置",
                con_name:SettingViewController(),
                icon:#imageLiteral(resourceName: "tabbar_setting").withRenderingMode(.alwaysOriginal),
                selected_icon: #imageLiteral(resourceName: "tabbar_setting_selected").withRenderingMode(.alwaysOriginal)
            ]]
        
        for item in viewConDetails {
            let viewCon = item[con_name] as! UIViewController
            let icon = item[icon] as! UIImage
            let iconSelected = item[selected_icon] as! UIImage
            let tabbar_title = item[title] as! String
            viewCon.tabBarItem = UITabBarItem.init(title: tabbar_title, image: icon, selectedImage: iconSelected)
            viewCon.navigationItem.title = tabbar_title
            addChildViewController(UINavigationController.init(rootViewController: viewCon))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
