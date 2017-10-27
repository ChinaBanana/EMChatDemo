//
//  InputContentView.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/23.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit
import SnapKit

protocol InputContentViewDelegate {
    func returnBtnClicked(_ text:String) -> ()
}

class InputContentView: UIView {

    let textView = UITextView.init()
    let videoBtn = UIButton.init()
    let moreBtn = UIButton.init()
    
    var delegate:InputContentViewDelegate?
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: 50))
        addSubview(textView)
        addSubview(videoBtn)
        addSubview(moreBtn)
        videoBtn.frame = CGRect.init(x: Limit.margin_left, y: Limit.margin_left, width: 30, height: 30)
        videoBtn.backgroundColor = .black
        
        textView.frame = CGRect.init(x: videoBtn.right + Limit.margin_left, y: 8, width: screen_width - 100, height: 34)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.light.cgColor
        textView.layer.cornerRadius = 5
        textView.delegate = self
        
        moreBtn.frame = CGRect.init(x: textView.right + Limit.margin_left, y: videoBtn.top, width: videoBtn.width, height: videoBtn.height)
        moreBtn.backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InputContentView : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            guard delegate != nil else {
                return true
            }
            delegate?.returnBtnClicked(textView.text)
            textView.text = ""
            return false
        }
        return true
    }
}
