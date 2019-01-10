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
//  UIConstant
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UIConstant.swift
// @abstract UI宏
// @discussion 全局UI宏定义
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

@available(*, deprecated, message: "Extensions directly on is_iPhoneX in UIConstant is deprecated. Use `UIDevice.rat.isIPhoneXSeries` instead.", renamed: "UIDevice.rat.isIPhoneXSeries")
public var is_iPhoneX: Bool {
    return (UIScreen.main.bounds.height == 812.0 && UIScreen.main.bounds.width == 375.0)
}

/// Status Bar 默认高度
public let StatusBarDefaultHeight: CGFloat = UIDevice.rat.isIPhoneXSeries ? 44.0 : 20.0

/// Navigation Bar 默认高度
public let NavigationBarDefaultHeight: CGFloat = 44.0

/// Top Layout 默认高度
public var TopLayoutDefaultHeight: CGFloat {
    return StatusBarDefaultHeight + NavigationBarDefaultHeight
}

/// Tab Bar 默认高度
public let TabBarDefaultHeight: CGFloat = 49.0

/// Tool Bar 默认高度
public let ToolBarDefaultHeight: CGFloat = 44.0

/// 视图默认间距
public let ViewDefaultInterval: CGFloat = 8.0

/// Label 默认高度
public let LabelDefaultHeight: CGFloat = 21.0

/// Button 默认高度
public let ButtonDefaultHeight: CGFloat = 44.0

/// TextField 默认高度
public let TextFieldDefaultHeight: CGFloat = 30.0

/// TableViewCell 默认高度
public let TableViewCellDefaultHeight: CGFloat = 44.0

/// Home Indicator 所在区域高度
public let HomeIndicatorAreaHeight: CGFloat = 34.0
