//
//  LoginViewController.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    let usernameTF = UITextField()
    let passwordTF = UITextField()
    let registerBtn = UIButton()
    let loginBtn = UIButton()
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.background
        navigationItem.title = "登录"
        
        view.addSubview(usernameTF)
        view.addSubview(passwordTF)
        view.addSubview(registerBtn)
        view.addSubview(loginBtn)
        
        usernameTF.frame = CGRect.init(x: 80, y: 150, width: screen_width - 160, height: 35)
        usernameTF.leftViewMode = .always
        usernameTF.leftView = UIImageView.init(image: #imageLiteral(resourceName: "account"))
        usernameTF.leftView?.contentMode = .scaleAspectFit
        usernameTF.leftView?.width = 50
        usernameTF.clearButtonMode = .whileEditing
        usernameTF.placeholder = "Account"
        usernameTF.setBottomBorder()
        
        passwordTF.frame = CGRect.init(x: usernameTF.left, y: usernameTF.bottom + 10, width: usernameTF.width, height: usernameTF.height)
        passwordTF.leftViewMode = .always
        passwordTF.leftView = UIImageView.init(image: #imageLiteral(resourceName: "password"))
        passwordTF.leftView?.contentMode = .scaleAspectFit
        passwordTF.leftView?.width = (usernameTF.leftView?.width)!
        passwordTF.clearButtonMode = .whileEditing
        passwordTF.placeholder = "Password"
        passwordTF.setBottomBorder()
        
        registerBtn.frame = CGRect.init(x: 40, y: passwordTF.bottom + 10, width: 100, height: 40)
        registerBtn.isHidden = false
        registerBtn.setTitle("Register", for: .normal)
        registerBtn.backgroundColor = UIColor.black
        registerBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        loginBtn.frame = CGRect.init(x: registerBtn.right + 10, y: registerBtn.top, width: screen_width - registerBtn.right - 10 - registerBtn.left, height: registerBtn.height)
        loginBtn.isHidden = false
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.backgroundColor = UIColor.black
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        Observable.combineLatest(usernameTF.rx.text, passwordTF.rx.text).map({ (username, psw) -> Bool in
            return username!.characters.count > 5 && psw!.characters.count > 5
        }).subscribe { (event) in
            if let element = event.element {
                self.loginBtn.isHidden = !element
                self.registerBtn.isHidden = !element
            }
        }.addDisposableTo(viewModel.disposeBag)
    }
    
    @objc func login() {
        viewModel.login(usernameTF.text!, password: passwordTF.text!)
    }
    
    @objc func register() {
        viewModel.register(usernameTF.text!, password: passwordTF.text!)
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
