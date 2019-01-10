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
// @abstract Timer拓展
// @discussion 实现基本的Timer操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import Foundation


extension Timer {
    public class codeable {
        public class func sheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
            if #available(iOS 10.0, *) {
                return Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: block)
            } else {
                let userInfo = ["block": block]
                return Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(blockInvoke(timer:)), userInfo: userInfo, repeats: repeats)
            }
        }
        
        public class func timer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer  {
            if #available(iOS 10.0, *) {
                return Timer(timeInterval: interval, repeats: repeats, block: block)
            } else {
                let userInfo = ["block": block]
                return Timer(timeInterval: interval, target: self, selector: #selector(blockInvoke(timer:)), userInfo: userInfo, repeats: repeats)
            }
        }
        
        @objc dynamic private class func blockInvoke(timer: Timer) {
            if let block = ((timer.userInfo as? [String: Any])?["block"]) as? () -> Void {
                block()
            }
        }
    }
    
}

extension Codeable where Base: Timer {
    
    public func start() {
        base.fireDate = Date.distantPast
    }
    
    public func start(afterTimeInterval interval: TimeInterval) {
        base.fireDate = Date(timeIntervalSinceNow: interval)
    }
    
    public func pause() {
        base.fireDate = Date.distantFuture;
    }
}
