//
//  SYDeviceable.swift
//
//  Created by WuhanSy on 2018/11/30.
//
//  Copyright © ShengYang. All rights reserved.
//

import UIKit

public protocol SYDeviceable {
    
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
