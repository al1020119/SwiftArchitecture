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
//  Created by iCocos on 2019/01/03.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftImport.swift
// @abstract Logger拓展
// @discussion 实现基本的Logger操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import Foundation

public struct Logger {
    
    public enum Level: Int {
        case info
        case debug
        case error
        case none
    }
    
    public static var level: Level = {
        #if DEBUG
        return .info
        #else
        return .none
        #endif
    }()
    
    
    private static let defaultDateFormatter = DateFormatter.codeable.formatter("yyyy-MM-dd HH:mm:ss.SSS", locale: .autoupdatingCurrent, timeZone: .autoupdatingCurrent)
    
    public static func info(_ items: Any..., separator: String = ", ", terminator: String = "\n", file: String = #file, method: String = #function, line: Int = #line, column: Int = #column) {
        internalLog(items, separator: separator, terminator: terminator, file: file, method: method, line: line, column: column, level: .info)
    }
    
    public static func debug(_ items: Any..., separator: String = ", ", terminator: String = "\n", file: String = #file, method: String = #function, line: Int = #line, column: Int = #column) {
        internalLog(items, separator: separator, terminator: terminator, file: file, method: method, line: line, column: column, level: .debug)
    }
    
    public static func error(_ items: Any..., separator: String = ", ", terminator: String = "\n", file: String = #file, method: String = #function, line: Int = #line, column: Int = #column) {
        internalLog(items, separator: separator, terminator: terminator, file: file, method: method, line: line, column: column, level: .error)
    }
    
    public static func log(_ items: Any..., separator: String = ", ", terminator: String = "\n", file: String = #file, method: String = #function, line: Int = #line, column: Int = #column, level: Logger.Level = .debug)
    {
        internalLog(items, separator: separator, terminator: terminator, file: file, method: method, line: line, column: column, level: level)
    }
    
    private static func internalLog(_ items: [Any], separator: String = ", ", terminator: String = "\n", file: String = #file, method: String = #function, line: Int = #line, column: Int = #column, level: Logger.Level = .debug) {
        if level.rawValue >= self.level.rawValue {
            let desc = (items.map { "\($0)" }).joined(separator: separator)
            let dateFormatter =  defaultDateFormatter
            let log = "[\(dateFormatter.string(for: Date()) ?? "unknown time")][\(level)][\((file as NSString).lastPathComponent):\(line)][\(method)] \(desc)"
            print(log, terminator: terminator)
        }
    }
}
