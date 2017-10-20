//
//  ContactsViewController.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView:UITableView!
    let viewModel = ContactsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        viewModel.refreshSubject.subscribe { (event) in
            switch event {
            case .next(let element):
                switch element {
                case .reloadSection1:
                    self.tableView.reloadSections(IndexSet.init(integer: 1), with: .none)
                }
            case .error(let error):
                debugPrint(error)
                break
            case .completed:
                debugPrint("disposed")
                break
            }
        }.addDisposableTo(viewModel.disposeBag)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addNewFriend))
        
        tableView = UITableView.init(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionFooterHeight = 10
        tableView.estimatedSectionHeaderHeight = 10
        view.addSubview(tableView)
    }
    
    @objc func addNewFriend() {
        viewModel.addFriend()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        switch indexPath.section {
        case 0:
            cell.configContent(viewModel.section0[indexPath.row])
        default:
            cell.configContent(viewModel.contacts[indexPath.row])
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return viewModel.contacts.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectedIndex(indexPath)
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
