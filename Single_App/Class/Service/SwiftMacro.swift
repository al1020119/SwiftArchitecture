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
//  SwiftMacro.swift
//
//  Created by iCocos on 2018/12/27.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class SwiftMacro.swift
// @abstract Swift宏
// @discussion 实现基本的swift宏操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import UIKit

/// 延迟加载
///
/// - Parameters:
///   - time: 加载时间
///   - execute: 执行内容
func delay(_ time: Double, execute: @escaping () -> Void) {
    if time > 0 {
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: execute)
    } else {
        DispatchQueue.main.async(execute: execute)
    }
}


/// 反射
///
/// - Parameter aClassName: 类名
/// - Returns: 类的实体
public func ClassFromString(_ aClassName: String) ->Swift.AnyClass? {
    let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String;
    return NSClassFromString("\(bundleName).\(aClassName)");
}

/// 通知
public let Single_NotificationDefault = NotificationCenter.default

/// 用户配置
public let Single_UserDefaultStandard = UserDefaults.standard


extension Timer {
    
    /// 延迟调用
    ///
    /// - Parameters:
    ///   - second: 延迟时间
    ///   - closure: 延迟操作
    static func dispatchDelay(_ second: Double, closure:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(second * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    // 每隔几秒运行一次
    @discardableResult static func runThisEvery(
        seconds: TimeInterval,
        startAfterSeconds: TimeInterval,
        handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = startAfterSeconds + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
}
