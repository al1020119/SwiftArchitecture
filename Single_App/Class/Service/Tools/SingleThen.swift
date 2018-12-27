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
//  SingleThen.swift
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class SingleThen.swift
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

public protocol Then {}

extension Then where Self: Any {
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


extension Then where Self: AnyObject {
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


extension NSObject: Then {}
