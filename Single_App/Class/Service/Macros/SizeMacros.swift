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
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class SizeMacros.swift
// @abstract <#类的描述#>
// @discussion <#类的功能#>
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
