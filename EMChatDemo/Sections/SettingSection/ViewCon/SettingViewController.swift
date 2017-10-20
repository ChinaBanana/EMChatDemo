//
//  SettingViewController.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let viewModel = SettingVM()
    
    var tableView:UITableView!
    var tableFooterView = UIView()
    var logOutBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        tableView = UITableView.init(frame: view.bounds, style: .grouped)
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionFooterHeight = 10
        tableView.estimatedSectionHeaderHeight = 10
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableFooterView.frame = CGRect.init(origin: .zero, size: CGSize.init(width: screen_width, height: 80))
        tableView.tableFooterView = tableFooterView
        
        logOutBtn.frame = CGRect.init(x: 50, y: 20, width: screen_width - 100, height: 40)
        logOutBtn.setTitle("Logout", for: .normal)
        logOutBtn.backgroundColor = UIColor.black
        logOutBtn.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        tableFooterView.addSubview(logOutBtn)
    }
    
    @objc func logOut() {
        viewModel.logOut()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
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
