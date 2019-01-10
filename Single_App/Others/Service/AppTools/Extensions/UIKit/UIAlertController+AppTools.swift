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
//  UIAlertController+AppTools
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UIAlertController+AppTools.swift
// @abstract 弹窗工具
// @discussion 实现系统的弹窗封装和配置
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension AppTools where Base: UIAlertController {
    
    /// 在视图中添加 Alert
    ///
    /// - Parameters:
    ///   - title: Alert 标题
    ///   - message: Alert 内容
    ///   - viewController: 展示 Alert 的视图
    ///   - actions: 完成的 actions
    public static func alert(title: String,
                             message: String,
                             in viewController: UIViewController,
                             actions: UIAlertAction...)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        viewController.present(alert, animated: true, completion: nil)
    }

    /// 在视图中添加 ActionSheet
    ///
    /// - Parameters:
    ///   - title: ActionSheet 标题
    ///   - message: ActionSheet 内容
    ///   - viewController: 展示 ActionSheet 的视图
    ///   - actions: 完成的 actions
    public static func actionSheet(title: String,
                                   message: String,
                                   in viewController: UIViewController,
                                   actions: UIAlertAction...)
    {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            actionSheet.addAction(action)
        }
        viewController.present(actionSheet, animated: true, completion: nil)
    }
}
