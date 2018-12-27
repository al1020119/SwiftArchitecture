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
//  UIWindow+Extension.swift
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UIWindow+Extension.swift
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension UIWindow {
    public func currentViewController() -> UIViewController {
        return self.findBestViewController(UIApplication.shared.keyWindow?.rootViewController)
    }
    
    private func findBestViewController(_ vc: UIViewController?) -> UIViewController {
        if ((vc?.presentedViewController) != nil) {
            return self.findBestViewController(vc?.presentedViewController)
        } else if (vc?.isKind(of: UISplitViewController.classForCoder()) == true) {
            let masterVC = vc as! UISplitViewController
            if masterVC.viewControllers.count > 0 {
                return self.findBestViewController(masterVC.viewControllers.last)
            } else {
                return vc!
            }
        }else if (vc?.isKind(of: UINavigationController.classForCoder()) == true) {
            let nav = vc as! UINavigationController
            if nav.viewControllers.count > 0 {
                return self.findBestViewController(nav.topViewController)
            }else {
                return vc!
            }
        } else if (vc?.isKind(of: UITabBarController.classForCoder()) == true) {
            let tabBar = vc as! UITabBarController
            if (tabBar.viewControllers?.count)! > 0 {
                return self.findBestViewController(tabBar.selectedViewController)
            }else {
                return vc!
            }
        } else {
            return vc!
        }
    }
}
