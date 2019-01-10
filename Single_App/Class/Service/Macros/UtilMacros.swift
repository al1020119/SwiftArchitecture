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
//  UtilMacros.swift
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class UtilMacros.swift
// @abstract 工具宏
// @discussion 实现基本的工具宏操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import UIKit

// iOS系统版本
let IS_IOS7 = (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0
let IS_IOS8 = (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0
let IS_IOS9 = (UIDevice.current.systemVersion as NSString).doubleValue >= 9.0
let IS_IOS10 = (UIDevice.current.systemVersion as NSString).doubleValue >= 10.0

func iOS8()->Bool{return((UIDevice.current.systemVersion as NSString).floatValue >= 8.0)}
func iOS10()->Bool{return((UIDevice.current.systemVersion as NSString).floatValue >= 10.0)}

func Single_PI() -> CGFloat {return CGFloat(Double.pi)}
func Single_PI_2() -> CGFloat {return CGFloat(Double.pi/2)}
