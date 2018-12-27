//
//  ViewExtension.swift
//  APP
//
//  Created by funny on 2018/8/30.
//  Copyright © 2018年 Funny. All rights reserved.
//

import UIKit

@objc extension UIView {

    // MARK: - 处理所有事件
    public func handleActions() -> () {

    }

    // MARK: - 添加UI
    public func setupUI() -> () {

    }

    // MARK: - 获取view 的控制器
    public func viewController() -> UIViewController? {

        var next = self.next
        while next != nil {
            if (next?.isKind(of: UIViewController.superclass()!))! {
                return next as? UIViewController
            }
            next = next?.next
        }
        return nil
    }

}
