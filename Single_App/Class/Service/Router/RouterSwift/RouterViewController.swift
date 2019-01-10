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
//  RouterViewController
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class RouterViewController.swift
// @abstract 路由控制与跳转
// @discussion 路由控制与跳转控制器
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

/// 路由跳转控制器
class RouterViewController: UIViewController {

    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /// Push操作控制器
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func routePushUIAction(_ sender: Any) {
        _ = RouterSwift.openController(className: "RouteFirstController", params: ["nickName": "alexluan", "address": "shanghai"])
    }

    /// Push操作ID
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func routePushFromModuleId(_ sender: Any) {
        _ = RouterSwift.openController(moduleId: 10002, params: ["nickName": "alexluan", "address": "yunan"])
    }

    /// Push操作Url
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func routePushFromUrl(_ sender: Any) {
        let routeUrl = "routeprotocol://routerproject:10002?nickName=alexluan&address=anhui"
        _ = RouterSwift.openUrl(url: routeUrl)
    }
    
    /// Routerweb Url
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func RouteWebUrl(_ sender: Any) {
        let routeUrl = "http://www.baidu.com"
        _ = RouterSwift.openUrl(url: routeUrl)
    }
}
