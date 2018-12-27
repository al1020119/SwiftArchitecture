//
//  UILabelExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//


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
