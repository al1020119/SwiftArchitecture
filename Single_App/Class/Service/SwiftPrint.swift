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
//  SwiftPrint.swift
//
//  Created by iCocos on 2018/12/27.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class SwiftPrint.swift
// @abstract 打印日志
// @discussion 根据类名，方法，行数，内容答应详细信息
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

/// 详细日志打印
///
/// - Parameters:
///   - message: 打印消息
///   - file: 文件名
///   - function: 方法
///   - line: 行数
func Log<T>(_ message:T, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        print("")
        print("----LOGBEGAN--- \(fileName): \(line) \(function)--------")
        print("\(dateString) \(message)")
        print("----LOGEND-----")
    #endif
}

/// 标准打印
///
/// - Parameters:
///   - message: 打印内容
///   - fileName: 文件名
///   - methodName: 方法
///   - lineNumber: 行数
public func KitLog<T>(_ message: T, fileName: String = #file, methodName: String =  #function, lineNumber: Int = #line) {
    #if DEBUG
    print("🛠 行号:\(lineNumber)\n🛠 类文件:\(fileName)\n🛠 方法:\(methodName)\n🛠 内容:\(message)\n");
    #endif
}
