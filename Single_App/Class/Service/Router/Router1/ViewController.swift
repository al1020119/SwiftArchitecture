//
//  ViewController.swift
//  RouterProject
//
//  Created by Alexluan on 2018/12/2.
//  Copyright © 2018年 Alexluan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func routePushUIAction(_ sender: Any) {
        _ = Router.openController(className: "RouteFirstController", params: ["nickName": "alexluan", "address": "shanghai"])
    }

    @IBAction func routePushFromModuleId(_ sender: Any) {
        _ = Router.openController(moduleId: 10002, params: ["nickName": "alexluan", "address": "yunan"])
    }

    @IBAction func routePushFromUrl(_ sender: Any) {
        let routeUrl = "routeprotocol://routerproject:10002?nickName=alexluan&address=anhui"
        _ = Router.openUrl(url: routeUrl)
    }
    @IBAction func RouteWebUrl(_ sender: Any) {
        let routeUrl = "http://www.baidu.com"
        _ = Router.openUrl(url: routeUrl)
    }
}
