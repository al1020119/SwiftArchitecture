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
//  TiledMapAnnotationView
//
//  Created by iCocos on 2019/01/01.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class TiledMapAnnotationView.swift
// @abstract 碎片地图标注View
// @discussion 实现和显示碎片地图标注
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

/// 碎片地图标注View
class TiledMapAnnotationView: TiledAnnotationView
{
    var markerColor: UIColor!
    {
        didSet
        {
            sizeToFit()
            setNeedsDisplay()
        }
    }

    /// 初始化
    ///
    /// - Parameters:
    ///   - frame: frame大小
    ///   - annotation: 标注
    ///   - reuseIdentifier: 标识符
    override init(frame: CGRect, annotation: TiledAnnotation, reuseIdentifier: String)
    {
        super.init(frame: frame, annotation: annotation, reuseIdentifier: reuseIdentifier)

        backgroundColor = UIColor.clear
        markerColor = UIColor.black
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize
    {
        return CGSize(width: 64, height: 64)
    }

    /// 绘制标注
    ///
    /// - Parameter rect: 标注frame
    override func draw(_ rect: CGRect)
    {
        // Marker
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 32, y: 8))
        bezierPath.addCurve(to: CGPoint(x: 14, y: 25.89), controlPoint1: CGPoint(x: 22.07, y: 8), controlPoint2: CGPoint(x: 14, y: 16.03))
        bezierPath.addCurve(to: CGPoint(x: 31.37, y: 57.55), controlPoint1: CGPoint(x: 14, y: 35.15), controlPoint2: CGPoint(x: 25.05, y: 46))
        bezierPath.addCurve(to: CGPoint(x: 31.99, y: 58), controlPoint1: CGPoint(x: 31.45, y: 57.82), controlPoint2: CGPoint(x: 31.7, y: 58))
        bezierPath.addCurve(to: CGPoint(x: 32.6, y: 57.54), controlPoint1: CGPoint(x: 32.27, y: 58), controlPoint2: CGPoint(x: 32.52, y: 57.81))
        bezierPath.addCurve(to: CGPoint(x: 50, y: 25.89), controlPoint1: CGPoint(x: 39.05, y: 46), controlPoint2: CGPoint(x: 50, y: 35.16))
        bezierPath.addCurve(to: CGPoint(x: 32, y: 8), controlPoint1: CGPoint(x: 50, y: 16.03), controlPoint2: CGPoint(x: 41.92, y: 8))
        bezierPath.close()
        bezierPath.miterLimit = 4;

        markerColor.setFill()
        bezierPath.fill()


        // The dot on the marker
        let dotColor = UIColor.white
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 32, y: 36))
        bezier2Path.addCurve(to: CGPoint(x: 21, y: 25), controlPoint1: CGPoint(x: 25.94, y: 36), controlPoint2: CGPoint(x: 21, y: 31.06))
        bezier2Path.addCurve(to: CGPoint(x: 32, y: 14), controlPoint1: CGPoint(x: 21, y: 18.93), controlPoint2: CGPoint(x: 25.94, y: 14))
        bezier2Path.addCurve(to: CGPoint(x: 43, y: 25), controlPoint1: CGPoint(x: 38.06, y: 14), controlPoint2: CGPoint(x: 43, y: 18.93))
        bezier2Path.addCurve(to: CGPoint(x: 32, y: 36), controlPoint1: CGPoint(x: 43, y: 31.06), controlPoint2: CGPoint(x: 38.06, y: 36))
        bezier2Path.close()

        dotColor.setFill()
        bezier2Path.fill()
    }

    /// 更新标注
    ///
    /// - Parameter annotation: 标注实体
    func update(forAnnotation annotation: TiledMapAnnotation?)
    {
        self.annotation = annotation

        let isSelectable = annotation?.isSelectable ?? true
        let isSelected = annotation?.isSelected ?? false

        if isSelectable {
            markerColor = isSelected ? UIColor.yellow : UIColor.red
        }
        else {
            markerColor = UIColor.darkGray
        }
    }
    
}
