//
//  RouteFirstController.swift
//  SwiftDemo
//
//  Created by Alexluan on 2018/11/30.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class RouteFirstController: LBaseController {

    var dic: Dictionary<String, Any?>?
    let visibleLabel = UILabel()

    convenience required init(params: Dictionary<String, Any?>) {
        self.init()
        print(params)
        self.dic = params
    }

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
