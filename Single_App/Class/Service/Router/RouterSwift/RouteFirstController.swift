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
//  RouteFirstController
//
//  Created by iCocos on 2019/01/04.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class RouteFirstController.swift
// @abstract 路由收个控制器
// @discussion 显示路由操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

class RouteFirstController: RouterBaseController {

    var dic: Dictionary<String, Any?>?
    let visibleLabel = UILabel()

    convenience required init(params: Dictionary<String, Any?>) {
        self.init()
        print(params)
        self.dic = params
    }

    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        visibleLabel.text = "\(String(describing: dic))"
        view.addSubview(visibleLabel)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        visibleLabel.textColor = UIColor.green
        visibleLabel.frame = view.bounds
        visibleLabel.numberOfLines = 0
        visibleLabel.textAlignment = .center
    }
}
