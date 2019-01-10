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
//  SwiftToast
//
//  Created by iCocos on 2019/01/04.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftToast.swift
// @abstract Swift弹窗
// @discussion 实现Swift显示a和弹窗操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Toast_Swift

private let timeoutInterval: TimeInterval = 60

/// 弹窗提示
final class Toast {
    
    /// 主窗口
    static var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    /// 加载中
    static func loading() {
        hide()
        //let maskView = UIView(frame: UIScreen.main.bounds)
        //maskView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        //keyWindow?.showToast(maskView, duration: timeoutInterval, position: .center, completion: { _ in
        //    Toast.hideActivity()
        //})
        keyWindow?.makeToastActivity(.center)
    }
    
    /// 显示弹窗信息
    ///
    /// - Parameters:
    ///   - info: 弹窗内心文字
    ///   - duration: 动画时间
    static func show(info: String, duration: TimeInterval = ToastManager.shared.duration) {
        hide()
        keyWindow?.makeToast(info, duration: duration, position: .center)
    }
    
    /// 显示图片信息
    ///
    /// - Parameters:
    ///   - image: 弹窗图片
    ///   - duration: 动画时间
    static func show(image: UIImage?, duration: TimeInterval = ToastManager.shared.duration) {
        hide()
        let imageView = UIImageView(image: image)
        keyWindow?.showToast(imageView, duration: duration)
    }
    
    /// 显示自定义View
    ///
    /// - Parameters:
    ///   - customView: 自定义View
    ///   - duration: 描述文字
    static func show(customView: UIView, duration: TimeInterval = ToastManager.shared.duration) {
        hide()
        keyWindow?.showToast(customView, duration: duration)
    }
    
    /// 隐藏进度
    static func hideActivity() {
        keyWindow?.hideToastActivity()
    }
    
    /// 隐藏操作
    static func hide() {
        keyWindow?.hideAllToasts(includeActivity: true)
    }
    
}
