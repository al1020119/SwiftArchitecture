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
//  Created by iCocos on 2019/01/04.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftImport.swift
// @abstract Date拓展
// @discussion 实现基本的Date操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import Foundation

extension DateFormatter {
    
    public class codeable {
        private static var cache: [String: DateFormatter] = [:]
        public class func formatter(_ format: String = "yyyy-MM-dd HH:mm:ss", locale: Locale = .autoupdatingCurrent, timeZone: TimeZone = .autoupdatingCurrent) -> DateFormatter {
            if let formatter = cache[format] {
                formatter.locale = locale
                formatter.timeZone = timeZone
                return formatter
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.locale = locale
            formatter.timeZone = timeZone
            cache[format] = formatter
            return formatter
        }
    }
    
}

extension Codeable where Base == Date {
    
    public func description(format: String = "yyyy-MM-dd HH:mm:ss", locale: Locale = .autoupdatingCurrent, timeZone: TimeZone = .autoupdatingCurrent) -> String {
        return DateFormatter.codeable.formatter(format, locale: locale, timeZone: timeZone).string(from: base)
    }
}

extension Codeable where Base == String {
    
    public func date(_ format: String = "yyyy-MM-dd HH:mm:ss", locale: Locale = .autoupdatingCurrent, timeZone: TimeZone = .autoupdatingCurrent) -> Date? {
        return DateFormatter.codeable.formatter(format, locale: locale, timeZone: timeZone).date(from: base)
    }
    
}
