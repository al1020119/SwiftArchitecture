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
//  Deviceable
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class Deviceable.swift
// @abstract 系统设备服务
// @discussion 实现系统设备相关服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

public protocol Deviceable {
    
    /// 设备类型
    static var device: DeviceType { get }
    
    /// 设备版本号
    static var systemVersion: Double { get }
    
    /// 尺寸 eg: 3.5 4.0 4.7 5.5
    static var diagonal: DeviceDiagonal { get }
    
    /// 判断是否是iPhone
    static var isPhone: Bool { get }
    
    /// 判断是否是iPad
    static var isPad: Bool { get }
    
    /// 是否是全面屏
    static var isFullScreen: Bool { get }
    
    /// 状态栏高度
    static var statusBarHeight: CGFloat { get }
    
    /// 导航栏高度
    static var navigationBarHeight: CGFloat { get }
    
    /// 状态栏和导航栏高度
    static var statusBarAndNavigationBarHeight: CGFloat { get }
    
    /// 选项栏和安全底部高度
    static var tabbarAndSafeBottomHeight: CGFloat { get }
    
    /// 安全底部高度
    static var safeBottomHeight: CGFloat { get }
    
}
