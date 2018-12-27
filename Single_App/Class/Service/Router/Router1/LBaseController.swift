//
//  LBaseController.swift
//  SwiftDemo
//
//  Created by Alexluan on 2018/11/30.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class LBaseController: UIViewController, AutoCreateProtocol {
    convenience required init(params: Dictionary<String, Any?>) {
        self.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
