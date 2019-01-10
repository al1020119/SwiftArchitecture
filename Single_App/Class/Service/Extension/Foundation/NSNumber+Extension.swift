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
//  NSNumber+Extension.swift
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class NSNumber+Extension.swift
// @abstract NSNumber拓展
// @discussion 实现NSNumber分类拓展操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

extension NSNumber {
    /// 设置String转换的格式
    ///
    /// - Parameters:
    ///   - style: 格式
    ///   - string: string要按照格式来
    /// - Returns: NSNumber
    class func numberFormatter(style: NumberFormatter.Style, string: String) -> NSNumber? {
        let formatter = NumberFormatter.init();
        formatter.numberStyle = style;
        return formatter.number(from: string);
    }
    
    /// 输出格式：123,456；每隔三个就有
    class func numberFormatterWithDecimal(string: String) -> NSNumber? {
        return NSNumber.numberFormatter(style: NumberFormatter.Style.decimal, string: string);
    }
    
    /// 百分比： 12,345,600%
    class func numberFormatterWithPercent(string: String) -> NSNumber? {
        return NSNumber.numberFormatter(style: NumberFormatter.Style.percent, string: string);
    }
    
    /// 一万一千一百一十一这样的格式转换成number
    class func numberFormatterWithSpellOut(string: String) -> NSNumber? {
        return NSNumber.numberFormatter(style: NumberFormatter.Style.spellOut, string: string);
    }
}
