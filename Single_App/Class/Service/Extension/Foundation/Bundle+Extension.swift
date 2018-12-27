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
//  Bundle+Extension.swift
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class Bundle+Extension.swift
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

extension Bundle {
    
    /// 最小适配的系统版本
    func minimumOSVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "MinimumOSVersion") as! String;
    }
    
    /// 项目名
    func bundleName() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String;
    }
    
    /// 项目版本号
    func bundleShortVersionString() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String;
    }
    
    /// 项目的Icon文件
    func bundleIconFile() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleIconFile") as! String;
    }
    
}
