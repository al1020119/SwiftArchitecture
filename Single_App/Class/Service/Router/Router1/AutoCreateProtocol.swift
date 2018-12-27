//
//  AutoCreateProtocol.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/29.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

protocol AutoCreateProtocol {
    init(params: Dictionary<String, Any?>)
}
extension AutoCreateProtocol {

}
extension AutoCreateProtocol where Self: LBaseController {
    // 创建并且复制参数
    //func createInitParameter() {
    //    self.parameter = ["nickName":"Alexluan"]
    //    print(#function)
    //}
}
