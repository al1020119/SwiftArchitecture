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
//  RouterHelper
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class RouterHelper.swift
// @abstract 路由辅助
// @discussion 实现路由辅助操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

func LPrint<N>(_ message: N) {

    #if DEBUG
    print(message)
    #endif
}
func LPrint<N>(_ message: N, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {

    #if DEBUG // 若是Debug模式下，则打印

    print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\(message)")
    #endif
}

extension Array {
    // 不区分大小写 返回第一个找到的 index
    func findIndex(item: String) -> Int? {
        let itemLower = item.lowercased()
        var index: Int?
        index = self.firstIndex { (itemcurrent) -> Bool in
            guard let itemStr = itemcurrent as? String else { return false }
            let itemStrlower  = itemStr.lowercased()
            return itemStrlower == itemLower
        }
        return index
    }
}

class RouterHelper: NSObject {

    class func getCurrentWindow() -> UIWindow? {
        let window = UIApplication.shared.keyWindow
        return window
    }

    class func getCurrentNavController() -> UIViewController? {
        guard let window = RouterHelper.getCurrentWindow() else {
            return nil
        }
        var vc = window.rootViewController
        while vc != nil {
            if let tabVC = vc as? UITabBarController {
                vc = tabVC.selectedViewController
                continue
            } else if let navVC = vc as? UINavigationController {
                vc = navVC.topViewController
                return vc
            } else {
                break
            }
        }
        return  vc
    }

    class func viewController(view: UIView) -> UIViewController? {
        var next: UIResponder?
        next = view.next!
        repeat {
            if ((next as?UIViewController) != nil) {
                return (next as! UIViewController)
            } else {
                next = next?.next
            }
        } while next != nil
        return nil
    }
    class func viewWindow(view: UIView) -> UIWindow? {
        var next: UIResponder?
        next = view.next!
        repeat {
            if ((next as? UIWindow) != nil) {
                return (next as! UIWindow)
            } else {
                next = next?.next
            }
        } while next != nil
        return nil
    }
}
