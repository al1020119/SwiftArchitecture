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
//  UIViewController+AppTools
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UIViewController+AppTools.swift
// @abstract 控制器工具
// @discussion 实现基本的控制层级操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension AppTools where Base: UIViewController {
    /// 获取位于最上层的视图
    public var topViewController: UIViewController {
        if base is UITabBarController {
            let tabBarController = base as! UITabBarController
            return tabBarController.selectedViewController!.rat.topViewController
        } else if base is UINavigationController {
            let navigationController = base as! UINavigationController
            return navigationController.visibleViewController!.rat.topViewController
        } else if let presentedViewController = base.presentedViewController {
            return presentedViewController.rat.topViewController
        } else {
            return base
        }
    }
}
