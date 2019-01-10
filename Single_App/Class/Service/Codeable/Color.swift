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
//  SwiftImport.swift
//
//  Created by iCocos on 2019/01/07.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftImport.swift
// @abstract Color拓展
// @discussion 实现基本的Color操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import Foundation
import UIKit

extension Codeable where Base == String {
    
    public func toColor(alpha: CGFloat = 1.0) -> UIColor? {
        let cstr = base.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        guard cstr.count >= 6 else {
            return nil
        }
        var startIndex = 0
        if cstr.hasPrefix("0X") {
            startIndex = 2
        }
        if cstr.hasPrefix("#") {
            startIndex = 1
        }
        
        let rs = cstr.codeable.substring(from: startIndex, to: startIndex + 2)
        let gs = cstr.codeable.substring(from: startIndex + 2, to: startIndex + 4)
        let bs = cstr.codeable.substring(from: startIndex + 4, to: startIndex + 6)
        
        var red: UInt32 = 0x0
        var green: UInt32 = 0x0
        var blue: UInt32 = 0x0
        
        Scanner(string: rs!).scanHexInt32(&red)
        Scanner(string: gs!).scanHexInt32(&green)
        Scanner(string: bs!).scanHexInt32(&blue)
        
        let hexColor = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
        
        return hexColor
    }
}
