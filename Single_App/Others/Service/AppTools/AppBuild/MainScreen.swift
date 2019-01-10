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
//  MainScreen
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class MainScreen.swift
// @abstract Screen工具
// @discussion 实现屏幕的基本服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

public struct MainScreen {

    /// width of main screen
    public static var width: CGFloat { return self.size.width }
    /// height of main screen
    public static var height: CGFloat { return self.size.height }
    /// size of main screen
    public static var size: CGSize { return self.bounds.size }
    /// bounds of main screen
    public static var bounds: CGRect { return self.mainScreen.bounds }
    private static let mainScreen = UIScreen.main
}
