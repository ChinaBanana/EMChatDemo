//
//  ConversationViewController.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import RxSwift

class ConversationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel:ConversationVM!
    
    private var tableView:UITableView!
    private let inputBar = InputContentView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        viewModel = ConversationVM()
        viewModel.refreshUISubject.subscribe { (event) in
            if let element = event.element {
                switch element {
                case .title:
                    self.navigationItem.title = self.viewModel.conversation?.conversationId
                case .reloadTableView:
                    self.tableView.reloadData()
                case .reloadIndexPath(let indexpath):
                    self.tableView.reloadRows(at: [indexpath], with: .fade)
                    self.tableView.scrollToRow(at: IndexPath.init(item: self.viewModel.messages.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
                case .receiveNewMessage: 
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: [IndexPath.init(item: self.viewModel.messages.count - 1, section: 0)], with: .fade)
                    self.tableView.endUpdates()
                    self.tableView.scrollToRow(at: IndexPath.init(item: self.viewModel.messages.count - 1, section: 0), at: UITableViewScrollPosition.bottom, animated: false)
                }
            }
            }.addDisposableTo(viewModel.disposeBag)
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: screen_width, height: screen_height - 114), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.separatorStyle = .none
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        
        tableView.reloadData()
        
        inputBar.top = tableView.bottom
        inputBar.delegate = self
        view.addSubview(inputBar)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChangeFrame(_:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyBoardWillChangeFrame(_ notification:Notification) {
        if let info = notification.userInfo {
            let duration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
            let endFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            UIView.animate(withDuration: duration, animations: {
                self.inputBar.bottom = endFrame.origin.y
                self.tableView.height = self.inputBar.top - 66
//                self.tableView.bottom = self.inputBar.top
            })
            guard viewModel.messages.count > 0 else {
                return
            }
            tableView.scrollToRow(at: IndexPath.init(row: viewModel.messages.count - 1, section: 0), at: .bottom, animated: false)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConversationTableViewCell
        cell.configContent(viewModel.messages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.messages[indexPath.row].height
    }
}

extension ConversationViewController : InputContentViewDelegate {
    
    func returnBtnClicked(_ text:String) -> () {
        guard text != "" else {
            return
        }
        viewModel.sendTextMessage(text)
    }
}
