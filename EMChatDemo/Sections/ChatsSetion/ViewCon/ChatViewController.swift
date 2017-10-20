//
//  ChatViewController.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let viewModel = ChatVM()
    private var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        tableView = UITableView.init(frame: view.bounds, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        viewModel.refreshUISubject.subscribe { (event) in
            if let element = event.element {
                switch element {
                case .reloadTableView:
                    self.tableView.reloadData()
                }
            }
            }.addDisposableTo(viewModel.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        cell.configContent(viewModel.conversations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.conversations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
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
