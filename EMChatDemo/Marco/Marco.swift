//
//  Marco.swift
//  EMChatDemo
//
//  Created by Coco Wu on 2017/10/19.
//  Copyright © 2017年 parkingto.com. All rights reserved.
//

import UIKit

let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height

// MARK: methods
func timeOfTimeStamp(_ time:Double) -> String {
    let timeInterval = time / 1000
    let dateFormmater = DateFormatter.init()
    dateFormmater.dateFormat = "YYYY-mm-dd HH:MM"
    return dateFormmater.string(from: Date.init(timeIntervalSince1970: timeInterval))
}

func currentTimeStamp() -> TimeInterval {
    return Date().timeIntervalSince1970 * 1000
}

// MARK: enums and extensions
enum Limit {
    static let margin_left:CGFloat = 10
    static let margin_top:CGFloat = 8
    static let thumbImage:CGFloat = 120
}

enum UserDefaultsKey {
    static let username = "username"
    static let password = "password"
}

extension UIColor {
    static let main = UIColor.init(white: 0.2, alpha: 0.6)
    static let background = UIColor.init(white: 0.95, alpha: 1)
    static let light = UIColor.init(white: 0.5, alpha: 0.5)
}

extension UIFont {
    static let tiny = systemFont(ofSize: 10)
    static let small = systemFont(ofSize: 12)
    static let standard = systemFont(ofSize: 16)
    static let large = systemFont(ofSize: 18)
    static let huge = systemFont(ofSize: 20)
    static let superLarge = systemFont(ofSize: 24)
    
    static let boldTiny = boldSystemFont(ofSize: 10)
    static let boldSmall = boldSystemFont(ofSize: 12)
    static let boldStandard = boldSystemFont(ofSize: 16)
    static let boldLarge = boldSystemFont(ofSize: 18)
    static let boldHuge = boldSystemFont(ofSize: 20)
    static let boldSuperLarge = boldSystemFont(ofSize: 24)
}
