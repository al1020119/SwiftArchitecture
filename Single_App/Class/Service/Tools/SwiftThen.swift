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
//  SwiftThen.swift
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftThen.swift
// @abstract Swift协议操作
// @discussion 实现Swift基本协议
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

/// 协议定义
public protocol Then {}

// MARK: - 数组关联操作
extension Then where Self: Any {
    
    /// 任何协议块
    ///
    /// - Parameter block: 代码块
    /// - Returns: 协议本身
    public func then_Any( block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
    /*
     let  _ = UILabel().then_Any { (label) in
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Then协议库"
        label.frame = CGRect.init(x: 20, y: 200, width: 150, height: 40)
        view.addSubview(label)
     }
     */
}


// MARK: - 对象协议操作
extension Then where Self: AnyObject {
    
    /// 对象协议
    ///
    /// - Parameter block: 代码块
    /// - Returns: 协议本身
    public func then( block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
    /*
     let  _ = UILabel().then { (label) in
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Then协议库"
        label.frame = CGRect.init(x: 20, y: 200, width: 150, height: 40)
        view.addSubview(label)
     }
     */
}


// MARK: - OC协议模式
extension NSObject: Then {}
