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
//  SQLiteLogger
//
//  Created by iCocos on 2019/01/05.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SQLiteLogger.swift
// @abstract 数据库日志
// @discussion 实现基本的数据库层级日志
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

public enum LogLevel:Int {
    case debug = 1,info,warn,error
}

func LogDebug(_ message: Any = "", file: String = #file, line: Int = #line, function: String = #function) {
    if SQLiteConfig.logLevel == .debug {
        print( "***[debug]***-\(name(of: file))[\(line)]:\(function) --> \(message)")
    }
}

func LogInfo(_ message: Any = "", file: String = #file, line: Int = #line, function: String = #function) {
    if SQLiteConfig.logLevel.rawValue >= LogLevel.info.rawValue {
        print( "***[info]***-\(name(of: file))[\(line)]:\(function) --> \(message)")
    }
}

func LogWarn(_ message: Any = "", file: String = #file, line: Int = #line, function: String = #function) {
    if SQLiteConfig.logLevel.rawValue >= LogLevel.warn.rawValue {
        print( "***[warn]***-\(name(of: file))[\(line)]:\(function) --> \(message)")
    }
}

func LogError(_ message: Any = "", file: String = #file, line: Int = #line, function: String = #function) {
    print( "***[error]***-\(name(of: file))[\(line)]:\(function) --> \(message)")
}

private func name(of file:String) -> String {
    return URL(fileURLWithPath: file).lastPathComponent
}

func LogDebug(_ message:  Any?) {
    Log("***[debug]***\(String(describing: message))")
}

func LogDebug(_ format:  @autoclosure () -> String, _ arguments: CVarArg...) {
    LogDebug(String(format: format(), arguments: arguments))
}

func LogInfo(_ message:  Any?) {
    Log("***[info]***\(String(describing: message))")
}

func LogInfo(_ format:  @autoclosure () -> String, _ arguments: CVarArg...) {
    LogInfo(String(format: format(), arguments: arguments))
}

func LogWarn(_ message:  Any?) {
    Log("***[warn]***\(String(describing: message))")
}

func LogWarn(_ format:  @autoclosure () -> String, _ arguments: CVarArg...) {
    LogWarn(String(format: format(), arguments: arguments))
}

func LogError(_ message:  Any?) {
    Log("***[error]***\(String(describing: message))")
}

func LogError(_ format:  @autoclosure () -> String, _ arguments: CVarArg...) {
    LogError(String(format: format(), arguments: arguments))
}

