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
//  UIImage+AppTools
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UIImage+AppTools.swift
// @abstract 图片工具
// @discussion 实现基本的图片操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension AppTools where Base: UIImage {
    /// Image 对应的 data
    public var data: Data? {
        guard let jpegData = base.jpegData(compressionQuality: 1.0) else {
            guard let pngData = base.pngData() else { return nil }
            return pngData
        }
        return jpegData
    }

    /// Image 对应的 Base64 String
    public var base64String: String? {
        guard let data = self.data else { return nil }
        return data.base64EncodedString()
    }

     /// 创建矩形图像
     ///
     /// - Parameters:
     ///   - size: 尺寸
     ///   - backColor: 背景色(默认`white`)
     ///   - borderColor: 边线颜色(默认`lightGray`)
     ///   - borderWidth: 边线宽度(默认`1.0`)
     /// - Returns: 新创建的矩形图像
     public func createRectImage(size: CGSize?,
                                backColor: UIColor = .white,
                                borderColor: UIColor = .lightGray,
                                borderWidth: CGFloat = 1.0) -> UIImage?
    {
        var size = size
        if size == nil {
            size = base.size
        }

        // 依据新图片的大小创建绘制区域
        let rect = CGRect(origin: .zero, size: size!)

        // 1.图像的上下文 - 内存中开辟一个地址, 跟屏幕无关
        /**
         * 1> size:   绘图的尺寸
         * 2> opaque: 不透明:false(透明) / true(不透明)
         * 3> scale:  屏幕分辨率,默认情况下生成的图像使用'1.0'的分辨率,图像质量不好
         *            可以指定'0',会选择当前设备的屏幕分辨率
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)

        // 2.背景填充(在裁切之前做填充)
        backColor.setFill()
        UIRectFill(rect)

        // 3.绘图'drawInRect'就是在指定区域内重绘图片
        base.draw(in: rect)

        // 4.绘制边线
        // 4.1 按照新尺寸的图片边界实例化一个路径
        let path = UIBezierPath(rect: rect)
        // 4.2 设置边线颜色
        borderColor.setStroke()
        // 4.3 设置边线宽度
        path.lineWidth = borderWidth
        // 4.4 绘制边线
        path.stroke()

        // 5.取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()

        // 6.关闭上下文
        UIGraphicsEndImageContext()
        
        // 7.返回结果
        return result
    }

    /// 创建圆角图像
    ///
    /// - Parameters:
    ///   - size: 尺寸
    ///   - backColor: 背景色(默认`white`)
    ///   - borderColor: 边线颜色(默认`lightGray`)
    ///   - borderWidth: 边线宽度(默认`1.0`)
    /// - Returns: 新创建的圆角图像
    public func createCircleImage(size: CGSize?,
                                  backColor: UIColor = .white,
                                  borderColor: UIColor = .lightGray,
                                  borderWidth: CGFloat = 1.0) -> UIImage?
    {
        var size = size
        if size == nil {
            size = base.size
        }

        // 依据新图片的大小创建绘制区域
        let rect = CGRect(origin: .zero, size: size!)

        // 1.图像的上下文 - 内存中开辟一个地址, 跟屏幕无关
        /**
         * 1> size:   绘图的尺寸
         * 2> opaque: 不透明:false(透明) / true(不透明)
         * 3> scale:  屏幕分辨率,默认情况下生成的图像使用'1.0'的分辨率,图像质量不好
         *            可以指定'0',会选择当前设备的屏幕分辨率
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)

        // 2.背景填充(在裁切之前做填充)
        backColor.setFill()
        UIRectFill(rect)

        // 实例化一个圆形的路径
        let path = UIBezierPath(ovalIn: rect)
        // 进行路径裁切 - 后续的绘图, 都会出现在圆形路径内部, 外部的全部裁切掉
        path.addClip()

        // 3.绘图'drawInRect'就是在指定区域内拉伸屏幕
        base.draw(in: rect)

        // 4.绘制内切的圆形
        // 4.1 设置边线颜色
        borderColor.setStroke()
        // 4.2 设置边线宽度
        path.lineWidth = borderWidth
        // 4.3 绘制边线
        path.stroke()

        // 5.取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()

        // 6.关闭上下文
        UIGraphicsEndImageContext()
        
        // 7.返回结果
        return result
    }

    /// 创建圆角矩形图像
    ///
    /// - Parameters:
    ///   - size: 尺寸
    ///   - cornerRadius: 圆角半径
    ///   - backColor: 背景色(默认`white`)
    ///   - borderColor: 边线颜色(默认`lightGray`)
    ///   - borderWidth: 边线宽度(默认`1.0`)
    /// - Returns: 新创建的圆角矩形图像
    public func createRoundRectImage(size: CGSize?,
                                     cornerRadius: CGFloat,
                                     backColor: UIColor = .white,
                                     borderColor: UIColor = .lightGray,
                                     borderWidth: CGFloat = 1.0) -> UIImage?
    {
        var size = size
        if size == nil {
            size = base.size
        }

        // 依据新图片的大小创建绘制区域
        let rect = CGRect(origin: .zero, size: size!)

        // 1.图像的上下文 - 内存中开辟一个地址, 跟屏幕无关
        /**
         * 1> size:   绘图的尺寸
         * 2> opaque: 不透明:false(透明) / true(不透明)
         * 3> scale:  屏幕分辨率,默认情况下生成的图像使用'1.0'的分辨率,图像质量不好
         *            可以指定'0',会选择当前设备的屏幕分辨率
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)

        // 2.背景填充(在裁切之前做填充)
        backColor.setFill()
        UIRectFill(rect)

        // 实例化一个圆角矩形的路径
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        // 进行路径裁切 - 后续的绘图, 都会出现在圆角矩形路径内部, 外部的全部裁切掉
        path.addClip()

        // 3.绘图'drawInRect'就是在指定区域内拉伸屏幕
        base.draw(in: rect)

        // 4.绘制边线
        // 4.1 设置边线颜色
        borderColor.setStroke()
        // 4.2 设置边线宽度
        path.lineWidth = borderWidth
        // 4.3 绘制边线
        path.stroke()

        // 5.取得结果
        let result = UIGraphicsGetImageFromCurrentImageContext()

        // 6.关闭上下文
        UIGraphicsEndImageContext()
        
        // 7.返回结果
        return result
    }
}
