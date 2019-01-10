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
//  SwiftImport.swift
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftImport.swift
// @abstract Image拓展
// @discussion 实现基本的Image操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import Foundation
import UIKit

extension UIImage {
    public class codeable { // 加入调用命名空间js
        // 颜色渐变 默认左右方向
        public class func gradientImage(gradientColors: [UIColor],
                                        size: CGSize = CGSize.init(width: 10, height: 10),
                                        start: CGPoint = .zero,
                                        end: CGPoint?) ->  UIImage?
        {
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            var pEnd: CGPoint = CGPoint (x: size.width, y: 0)
            if let e:CGPoint = end {
                pEnd = e
            }
            let colors = gradientColors.map {(color: UIColor) -> AnyObject? in return color.cgColor  } as NSArray
            if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil), let context = UIGraphicsGetCurrentContext()  {
                // 第二个参数是起始位置，第三个参数是终止位置
                context.drawLinearGradient(gradient, start: start, end: pEnd, options: CGGradientDrawingOptions(rawValue: 0));
            }
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    }
}
