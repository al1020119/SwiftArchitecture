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
//  SizeMacros.swift
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SizeMacros.swift
// @abstract Size宏
// @discussion 实现基本的Size宏操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import UIKit

/// 屏幕宽度
let SCREEN_WIDTH           = UIScreen.main.bounds.width
/// 屏幕高度
let SCREEN_HEIGHT          = UIScreen.main.bounds.height
// 状态栏高度
let STATUSBAR_HEIGHT : CGFloat = 20.0
/// 导航栏高度 64
let NAVIGATIONBAR_HEIGHT: CGFloat = 64.0
/// tabbar的高度 49
let TABBAR_HEIGHT: CGFloat = 49.0

let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height
let gridWidth : CGFloat = (screenSize.width/2)-5.0
let navigationHeight : CGFloat = 44.0
let statubarHeight : CGFloat = 20.0
let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statubarHeight

func SingleScreenWidth() -> CGFloat{return UIScreen.main.bounds.size.width}
func SingleScreenHeight() -> CGFloat{return UIScreen.main.bounds.size.height}

/***********************************iPhoneX判断**********************************************/

/** ModelSize */
//+ (BOOL)isIphoneX_Model {
//    BOOL response = [UIScreen instancesRespondToSelector:@selector(currentMode)];
//    return response ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
//}

///** StatusBar */
//+ (BOOL)isIphoneX_StBar {
//    UIApplication *app = [UIApplication sharedApplication];
//    UIView *statusBar = [app valueForKeyPath:@"statusBar"];
//    BOOL isModernStatusBar = [statusBar isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")];
//    return isModernStatusBar; // 在 iPhone X 上 statusBar 属于 UIStatusBar_Modern ，需要特殊处理
//}

///** BoundsSize */
//+ (BOOL)isIphoneX_Bounds {
//    CGRect bounds = [[UIScreen mainScreen] bounds];
//    return (bounds.size.height == 812.0 && bounds.size.width == 375.0);
//}
