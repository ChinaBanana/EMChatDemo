//
//  AddFriendViewController.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    private var searchCon:UISearchController!
    private let searchResultView = UIView()
    private let headImage = UIImageView.init(image: #imageLiteral(resourceName: "default_head"))
    private let nameLabel = UILabel()
    private let addBtn = UIButton()
    private let viewModel = AddFriendVM()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        navigationItem.title = "搜索好友"
        view.addSubview(searchResultView)
        searchResultView.addSubview(headImage)
        searchResultView.addSubview(nameLabel)
        searchResultView.addSubview(addBtn)
        
        searchResultView.frame = CGRect.init(x: 0, y: 126, width: screen_width, height: 50)
        searchResultView.backgroundColor = UIColor.white
        
        headImage.frame = CGRect.init(x:Limit.margin_left , y: 6, width: 38, height: 38)
        headImage.layer.cornerRadius = 4
        headImage.clipsToBounds = true
        
        nameLabel.frame = CGRect.init(x: headImage.right + 10, y: 0, width: 200, height: searchResultView.height)
        nameLabel.font = UIFont.standard
        nameLabel.textColor = UIColor.black
        
        addBtn.frame = CGRect.init(x: screen_width - 100, y: 10, width: 80, height: 30)
        addBtn.setTitle("添加", for: .normal)
        addBtn.backgroundColor = UIColor.red
        addBtn.addTarget(self, action: #selector(addBtnClicked(_:)), for: .touchUpInside)
        
        searchCon = UISearchController.init(searchResultsController: nil)
        searchCon.delegate = self
        searchCon.searchResultsUpdater = self
        searchCon.searchBar.delegate = self
        searchCon.searchBar.tintColor = UIColor.white
        searchCon.searchBar.barStyle = UIBarStyle.blackTranslucent
        
        if #available(iOS 11, *) {
            navigationItem.searchController = searchCon
        }else {
            
        }
    }
    
    @objc func addBtnClicked(_ sender:UIButton) {
        guard let id = nameLabel.text else {
            return
        }
        viewModel.addFriend(id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddFriendViewController : UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        nameLabel.text = searchController.searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchCon.dismiss(animated: true, completion: nil)
        
    }
}
