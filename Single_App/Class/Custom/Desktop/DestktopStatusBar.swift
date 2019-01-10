
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
//  DestktopStatusBar.swift
//
//  Created by iCocos on 2019/1/4.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class DestktopStatusBar
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

class DestktopStatusBar: UIView, SwiftNibable {

    @IBOutlet weak var singleImage: UIImageView!            // 信号图标：满格图片
    @IBOutlet weak var operatorText: UILabel!               // 运营商类型：电信，联通，移动
    @IBOutlet weak var carrierTypeText: UIImageView!        // 网络类型图标：蜂窝与Wifi图片
    @IBOutlet weak var batteryValuePercentage: UILabel!     // 电量百分比值
    @IBOutlet weak var batteryValueProgress: UIView!        // 电量进度条值
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
