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
//  UINavigationBar+AppTools
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UINavigationBar+AppTools.swift
// @abstract 导航条工具
// @discussion 实现基本的导航条主题配置
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension AppTools where Base: UINavigationBar {
    /// 修改 Navigation Bar 的背景颜色
    ///
    /// - Parameter color: 提供给 Navigation Bar 的背景的 tint color
    public static func barTintColor(_ color: UIColor) {
        UINavigationBar.appearance().barTintColor = color
    }

    /// 修改 Navigation item 的 tint color
    ///
    /// - Parameter color: 提供给 Navigation item 的 tint color
    public static func tintColor(_ color: UIColor) {
        UINavigationBar.appearance().tintColor = color
    }

    /// 修改 Navigation Bar 的文字颜色
    ///
    /// - Parameter color: 提供给 Navigation Bar 上文字的颜色
    public static func titleTextColor(_ color: UIColor) {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: color]
    }
}
