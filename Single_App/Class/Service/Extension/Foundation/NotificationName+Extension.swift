//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
//                  http://www.icocos.cn                       //
//                 https://icocos.github.io                    //
//                https://al1020119.github.io                  //
// **************************************************************
//  ************  😂🤔 曹理鹏(梦工厂@iCocos) 🤔😂  ************  //
// **************************************************************
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
//
//  Single_App
//  NotificationName+Extension.swift
//
//  Created by iCocos on 2019/01/05.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class NotificationName+Extension.swift
// @abstract NotificationName拓展
// @discussion 实现NotificationName分类拓展操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
extension Notification.Name {
    // 自定义全局静态通知名
    public struct SingleLocation{
        public static let disable = Notification.Name.init(rawValue: "SingleLocationServicesDisable")
    }
}

extension NotificationCenter {
    static func post(customeNotification name: FCNotification, object: Any? = nil){
        NotificationCenter.default.post(name: name.notificationName, object: object)
    }
}

enum FCNotification: String {
    case userLogout
    case userLogin
    
    var stringValue: String {
        return "FC" + rawValue
    }
    
    var notificationName: NSNotification.Name {
        return NSNotification.Name(stringValue)
    }
}
