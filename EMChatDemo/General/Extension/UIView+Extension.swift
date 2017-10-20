//
//  UIView+Extension.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/20.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

extension UIView {
    var left:CGFloat {
        set {
            frame = CGRect.init(origin: CGPoint.init(x: newValue, y: frame.origin.y), size: frame.size)
        }
        get {
            return frame.origin.x
        }
    }
    
    var top:CGFloat{
        set {
            frame = CGRect.init(origin: CGPoint.init(x: frame.origin.x, y: newValue), size: frame.size)
        }
        get {
            return frame.origin.y
        }
    }
    
    var width:CGFloat {
        set {
            frame = CGRect.init(origin: frame.origin, size: CGSize.init(width: newValue, height: frame.size.height))
        }
        get {
            return frame.size.width
        }
    }
    
    var height:CGFloat {
        set {
            frame = CGRect.init(origin: frame.origin, size: CGSize.init(width: frame.size.width, height: newValue))
        }
        get {
            return frame.size.height
        }
    }
    
    var right:CGFloat {
        set {
            frame = CGRect.init(origin: CGPoint.init(x: newValue - frame.size.width, y: frame.origin.y), size: frame.size)
        }
        get {
            return frame.origin.x + frame.size.width
        }
    }
    
    var bottom:CGFloat {
        set {
            frame = CGRect.init(origin: CGPoint.init(x: frame.origin.x, y: newValue - frame.size.height), size: frame.size)
        }
        get {
            return frame.origin.y + frame.size.height
        }
    }
}

extension UIView {
    
    func setBottomBorder() -> () {
        let line = UIView.init(frame: CGRect.init(x: 0, y: self.height - 1, width: self.width, height: 1))
        line.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        addSubview(line)
    }
    
    class func bage() -> UILabel {
        let label = UILabel.init(frame: CGRect.init(origin: .zero, size: CGSize.init(width: 14, height: 14)))
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        label.backgroundColor = .red
        label.textColor = .white
        label.textAlignment = .center
        label.font = .small
        label.isHidden = true
        return label
    }
    
    class func dot() -> UIView {
        let view = UIView.init(frame: CGRect.init(origin: .zero, size: CGSize.init(width: 8, height: 8)))
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.backgroundColor = .red
        view.isHidden = true
        return view
    }
}
