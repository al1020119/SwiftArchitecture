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
//  TiledAnnotationView
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class TiledAnnotationView.swift
// @abstract 碎片标注View
// @discussion 显示在碎片地图上的标注控件
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

@objc class TiledAnnotationView: UIView
{
    fileprivate var _position: CGPoint = CGPoint.zero
    fileprivate var _centerOffset: CGPoint = CGPoint.zero

    var annotation: TiledAnnotation?
    var reuseIdentifier: String = ""
    var position: CGPoint
    {
        get
        {
            return _position
        }
        set
        {
            if (!_position.equalTo(newValue)) {
                _position = newValue
                adjustCenter()
            }
        }
    }
    var centerOffset: CGPoint
    {
        get
        {
            return _centerOffset
        }
        set
        {
            if (!_centerOffset.equalTo(newValue)) {
                _centerOffset = newValue
                adjustCenter()
            }
        }
    }

    init(frame: CGRect, annotation: TiledAnnotation, reuseIdentifier: String)
    {
        super.init(frame: frame)

        self.annotation = annotation
        self.reuseIdentifier = reuseIdentifier
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func adjustCenter()
    {
        center = CGPoint(x: position.x + centerOffset.x, y: position.y + centerOffset.y)
    }
}

