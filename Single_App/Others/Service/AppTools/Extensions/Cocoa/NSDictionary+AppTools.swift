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
//  NSDictionary+AppTools
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class NSDictionary+AppTools.swift
// @abstract 字典工具
// @discussion 实现字典的基本功能操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

extension AppTools where Base: NSDictionary {
    /// 检验 NSDictionary 中是否存在某个 key
    ///
    /// - Parameter key: 待检验的 key
    /// - Returns: 检验结果的布尔值
    public func isHave(key: String) -> Bool {
       return base.value(forKey: key) != nil
    }
}

//  MARK: Main Bundle
extension NSDictionary {
    /**
     获取 Main Bundle 中某个文件的内容, 创建为 NSDictionary
     
     - parameter name: 文件名
     - parameter ext:  文件扩展名
     
     - returns: 文件路径
     */
    public convenience init?(mainBundlePathForResource name: String?, ofType ext: String?) {
        guard let path = Bundle.main.path(forResource: name, ofType: ext) else {
            print("Apptools: NSDictionary init with main bundle path for resource of type is nil")
            return nil
        }
        self.init(contentsOfFile: path)
    }
}

//  MARK: Check key exist or not
extension NSDictionary {
    /**
     检验 NSDictionary 中是否存在某个 key
     
     - parameter key: 待检验的 key
     
     - returns: 检验结果的布尔值
     */
    @available(*, deprecated, message: "Extensions directly on NSDictionary are deprecated. Use `NSDictionary.rat.isHave(key:)` instead.", renamed: "rat.isHave(key:)")
    func rat_isHaveKey(_ key: String) -> Bool {
        let keys = self.allKeys as! [String]
        for aKey: String in keys {
            if key == aKey {
                return true
            }
        }
        return false
    }
}
