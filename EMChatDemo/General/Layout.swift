//
//  Layout.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/23.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

struct Layout {
    
    var left:CGFloat = 0
    var top:CGFloat = 0
    var width:CGFloat = 0
    var height:CGFloat = 0
    var right:CGFloat {
        set {
            left = newValue - width
        }
        get {
            return left + width
        }
    }
    
    var bottom:CGFloat {
        set {
            top = newValue - height
        }
        get {
            return top + height
        }
    }
    
    var origin:CGPoint {
        set {
            left = newValue.x
            top = newValue.y
        }
        get {
            return CGPoint.init(x: left, y: top)
        }
    }
    
    var size:CGSize {
        set {
            width = newValue.width
            height = newValue.height
        }
        get {
            return CGSize.init(width: width, height: height)
        }
    }
    
    var frame:CGRect {
        set {
            left = newValue.origin.x
            top = newValue.origin.y
            width = newValue.size.width
            height = newValue.size.height
        }
        
        get {
            return CGRect.init(x: left, y: top, width: width, height: height)
        }
    }
    
    var bounds:CGRect {
        get {
            return CGRect.init(origin: .zero, size: CGSize.init(width: width, height: height))
        }
    }
}
