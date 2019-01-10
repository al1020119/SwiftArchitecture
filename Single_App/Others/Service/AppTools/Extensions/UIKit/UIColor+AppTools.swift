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
//  UIColor+AppTools
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UIColor+AppTools.swift
// @abstract 颜色工具
// @discussion 实现基本的颜色显示
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension AppTools where Base: UIColor {
    /// 通过指定的不透明度和 RGB 分量值, 返回一个颜色对象
    ///
    /// - Parameters:
    ///   - red: 红色分量的值 (0 ~ 255)
    ///   - green: 绿色分量的值 (0 ~ 255)
    ///   - blue: 蓝色分量的值 (0 ~ 255)
    ///   - alpha: 不透明度的值 (0 ~ 1)
    /// - Returns: 颜色对象
    public static func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }

    /// 通过指定的不透明度 和 一个用16进制数字表示 RGB 分量值的字符串, 返回一个颜色对象
    ///
    /// - Parameters:
    ///   - hexString: 以"#"或"0x"开头, 后面跟随6位(或3位)16进制数字 表示RGB分量值的字符串
    ///   - alpha: 不透明度 (0 ~ 1)
    /// - Returns: 颜色对象
    public static func color(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue:  CGFloat = 0.0
        var cString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()

        guard cString.hasPrefix("0X") || cString.hasPrefix("#") else {
            print("Invalid RGB hex string, missing '#' or '0x' as prefix.")
            return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }

        if cString.hasPrefix("0X") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 2)))
        } else if cString.hasPrefix("#") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 1)))
        }

        let scanner = Scanner(string: cString)
        var hexValue: CUnsignedLongLong = 0
        guard scanner.scanHexInt64(&hexValue) else {
            print("Scan hex error.")
            return UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        }

        switch (cString.count) {
        case 3:
            red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
            green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
            blue  = CGFloat(hexValue & 0x00F)              / 15.0

        case 6:
            red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
            blue  = CGFloat(hexValue & 0x0000FF)           / 255.0

        default:
            red = 0.0; green = 0.0; blue = 1.0
            NSLog("Invalid RGB hex string, number of characters after '#' or '0x' should be either 3 or 6.")
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
