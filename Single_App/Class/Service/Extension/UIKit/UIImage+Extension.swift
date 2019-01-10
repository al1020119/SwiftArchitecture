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
//  UIImage+Extension.swift
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class UIImage+Extension.swift
// @abstract UIImage拓展
// @discussion 实现UIImage分类拓展操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

enum UIImageContentMode: Int {
    case scaleToFill
    case scaleAspectFit
    case scaleAspectFill
    case bottom
}

extension UIImage {
    
    class func image(named name: String) -> UIImage? {
        return UIImage.init(named: name)
    }
    
    
    /// 给图片倒圆角
    func rounding() -> UIImage {
        let newImage = UIImage.roundingImage(image: self, size: self.size)
        if (newImage != nil) {
            return newImage!
        }
        return self
    }
    
    /// 给图片倒圆角
    class func roundingImage(image: UIImage, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let radius = size.width * 0.5
        let center = CGPoint.init(x: radius, y: radius)
        context?.addArc(center: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi) * 2.0, clockwise: true)
        context?.closePath()
        context?.clip()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.draw(image.cgImage!, in: CGRect.init(origin: CGPoint.zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    /// 用UIColor绘制图片
    class func image(withColor color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.set()
        UIRectFill(CGRect.init(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 重新绘制对应大小的图片
    func resize(withSize size: CGSize) -> UIImage {
        return self.resize(withSize: size, contentModel: .scaleToFill)
    }
    
    
    /// 重新绘制对应大小的图片
    func resize(withSize size: CGSize, contentModel: UIImageContentMode) -> UIImage {
        var scale = UIScreen.main.scale
        let targetSize = CGSize.init(width: size.width * scale, height: size.height * scale)
        UIGraphicsBeginImageContext(targetSize)
        var bounds = CGRect.zero
        switch contentModel {
        case .scaleToFill:
            bounds.size = targetSize
            break
        case .scaleAspectFit:
            scale = self.size.width / self.size.height
            let tempScale = targetSize.width / targetSize.height
            if scale < tempScale {
                bounds.size = CGSize.init(width: targetSize.height * scale, height: targetSize.height)
                bounds.origin.x = (targetSize.width - bounds.size.width) * 0.5
            }else {
                bounds.size = CGSize.init(width: targetSize.width, height: targetSize.width * scale)
                bounds.origin.x = (targetSize.height - bounds.size.height) * 0.5
            }
            break
        case .scaleAspectFill:
            scale = self.size.width / self.size.height
            let tempScale = targetSize.width / targetSize.height
            if scale > tempScale {
                bounds.size = CGSize.init(width: targetSize.height * scale, height: targetSize.height)
                bounds.origin.x = (targetSize.width - bounds.size.width) * 0.5
            }else {
                bounds.size = CGSize.init(width: targetSize.width, height: targetSize.width * scale)
                bounds.origin.x = (targetSize.height - bounds.size.height) * 0.5
            }
            break
            
        case .bottom:
                scale = self.size.width / self.size.height
                bounds.size = CGSize.init(width: targetSize.width, height: targetSize.width * scale)
                bounds.origin.y = targetSize.height - bounds.size.height
            break
        }
        
        self.draw(in: bounds)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (newImage != nil) {
            return newImage!
        }
        return self
    }
    
    /// 缩放图片，透明边缘
    func zoom(withScale scale: CGFloat) -> UIImage {
        let size = self.size
        UIGraphicsBeginImageContext(size)
        let bounds = CGRect.init(x: size.width * (1 - scale) * 0.5,
                                 y: size.height * (1 - scale) * 0.5,
                                 width: size.width * scale,
                                 height: size.height * scale)
        self.draw(in: bounds)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // 拉伸图片(中心位置)
    func stretchImage() -> UIImage {
        let left = self.size.width * 0.499
        let top = self.size.height * 0.499
        return self.resizableImage(withCapInsets: UIEdgeInsets.init(top: top, left: left, bottom: top, right: left), resizingMode: .stretch)
    }
    
    /// 用UIColor绘制圆角图
    class func roundingImage(withColor color: UIColor, size: CGSize, radius: CGFloat) -> UIImage {
        let targetSize = CGSize.init(width: UIScreen.main.scale * size.width,
                                     height: UIScreen.main.scale * size.height)
        let targetRadius = UIScreen.main.scale * radius
        
        UIGraphicsBeginImageContext(targetSize)
        let beziePath = UIBezierPath.init()
        beziePath.move(to: CGPoint.init(x: targetRadius, y: 0))
        beziePath.addLine(to: CGPoint.init(x: targetSize.width - targetRadius, y: 0))
        beziePath.addArc(withCenter: CGPoint.init(x: targetSize.width - targetRadius,
                                                  y: targetRadius),
                         radius: targetRadius,
                         startAngle: Single_PI() * 1.5,
                         endAngle: Single_PI() * 2.0,
                         clockwise: true)
        
        beziePath.addLine(to: CGPoint.init(x: targetSize.width,
                                           y: targetSize.height - targetRadius))
        beziePath.addArc(withCenter: CGPoint.init(x: targetSize.width - targetRadius,
                                                  y: targetSize.height - targetRadius),
                         radius: targetRadius,
                         startAngle: 0,
                         endAngle: Single_PI() * 0.5,
                         clockwise: true)
        
        beziePath.addLine(to: CGPoint.init(x: targetRadius, y: targetSize.height))
        beziePath.addArc(withCenter: CGPoint.init(x: targetRadius,
                                                  y: targetSize.height - targetRadius),
                         radius: targetRadius,
                         startAngle: Single_PI() * 0.5,
                         endAngle: Single_PI(),
                         clockwise: true)
        
        beziePath.addLine(to: CGPoint.init(x: 0, y: targetRadius))
        beziePath.addArc(withCenter: CGPoint.init(x: targetRadius, y: targetRadius),
                         radius: targetRadius,
                         startAngle: Single_PI(),
                         endAngle: Single_PI() * 1.5,
                         clockwise: true)
        color.setFill()
        beziePath.fill()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    /// 带边框的圆角图
    class func roundingImage(withColor color: UIColor, size: CGSize, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) -> UIImage {
        let targetSize = CGSize.init(width: UIScreen.main.scale * size.width,
                                     height: UIScreen.main.scale * size.height)
        let targetRadius = UIScreen.main.scale * radius
        let targetBorderWith = UIScreen.main.scale * borderWidth
        
        UIGraphicsBeginImageContext(targetSize)
        let pointA = CGPoint.init(x: targetRadius, y: targetBorderWith)
        let pointB = CGPoint.init(x: targetSize.width - targetRadius, y: targetBorderWith)
        
        let centerA = CGPoint.init(x: targetSize.width - targetRadius, y: targetRadius)
        let pointC = CGPoint.init(x: targetSize.width - targetBorderWith, y: targetSize.height - targetRadius)
        
        let centerB = CGPoint.init(x: targetSize.width - targetRadius, y: targetSize.height - targetRadius)
        let pointD = CGPoint.init(x: targetRadius, y: targetSize.height - targetBorderWith)
        
        let centerC = CGPoint.init(x: targetRadius, y: targetSize.height - targetRadius)
        let pointE = CGPoint.init(x: targetBorderWith, y: targetRadius)
        
        let centerD = CGPoint.init(x: targetRadius, y: targetRadius)
        
        let beziePath = UIBezierPath.init()
        beziePath.move(to: pointA)
        beziePath.addLine(to: pointB)
        beziePath.addArc(withCenter: centerA,
                         radius: targetRadius - targetBorderWith,
                         startAngle: Single_PI_2() * 3,
                         endAngle: Single_PI_2() * 4,
                         clockwise: true)
        beziePath.addLine(to: pointC)
        beziePath.addArc(withCenter: centerB,
                         radius: targetRadius - targetBorderWith,
                         startAngle: 0,
                         endAngle: Single_PI_2(),
                         clockwise: true)
        beziePath.addLine(to: pointD)
        beziePath.addArc(withCenter: centerC,
                         radius: targetRadius - targetBorderWith,
                         startAngle: Single_PI_2(),
                         endAngle: Single_PI(),
                         clockwise: true)
        beziePath.addLine(to: pointE)
        beziePath.addArc(withCenter: centerD,
                         radius: targetRadius - targetBorderWith,
                         startAngle: Single_PI(),
                         endAngle: Single_PI_2() * 3,
                         clockwise: true)
        color.setFill()
        beziePath.fill()
        
        borderColor.setStroke()
        beziePath.lineWidth = targetBorderWith
        beziePath.stroke()
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UIImage {
    
    //    55、image圆角
    //    - (UIImage *)circleImage
    //    {
    //    // NO代表透明
    //    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);
    //    // 获得上下文
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    // 添加一个圆
    //    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    //    // 方形变圆形
    //    CGContextAddEllipseInRect(ctx, rect);
    //    // 裁剪
    //    CGContextClip(ctx);
    //    // 将图片画上去
    //    [self drawInRect:rect];
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return image;
    //    }
    
    //    func circleImage() -> UIImage {
    //        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
    //        let ctx: CGContext = UIGraphicsGetCurrentContext()!
    //        let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
    //        CGContextAddEllipseInRect(ctx, rect)
    //    }
    
    
    
}
