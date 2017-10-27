//
//  SystemNotifyViewController.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/24.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import RxSwift

class SystemNotifyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let viewModel = SystemNotifyVM()
    
    private var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView.init(frame: view.bounds, style: .plain)
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SystemNotifyTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        viewModel.refreshUISubject.subscribe{ event in
            guard let element = event.element else {
                return
            }
            switch element {
            case .reloadTableVeiw:
                self.tableView.reloadData()
            }
        }.addDisposableTo(viewModel.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SystemNotifyTableViewCell
        cell.configCell(viewModel.requests[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.requests.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
