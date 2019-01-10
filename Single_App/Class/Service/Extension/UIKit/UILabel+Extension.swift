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
//  UILabel+Extension
//
//  Created by iCocos on 2019/01/05.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class UILabel+Extension.swift
// @abstract UILabel拓展
// @discussion 实现UILabel分类拓展操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension UILabel {
    
    convenience init(font: UIFont, color: UIColor, alignment: NSTextAlignment = .left) {
        self.init()
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
    }

    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, font: UIFont) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        self.font = font
        backgroundColor = UIColor.clear
        clipsToBounds = true
        textAlignment = .left
        isUserInteractionEnabled = true
    }

    // 获取预估Size
    func getEstimatedSize(_ width: CGFloat = CGFloat.greatestFiniteMagnitude, height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: height))
    }
}
