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
//  TopLayoutProtocols
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class TopLayoutProtocols.swift
// @abstract 顶部布局和配置
// @discussion 实现顶部View的布局和相关配置设置
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

protocol TopView {
    /// 页面顶部视图背景色
    var topColor: UIColor { get set }
    /// 状态栏颜色
    var statusColor: UIColor { get set }
    /// 导航栏颜色
    var naviColor: UIColor { get set }
}

extension TopView where Self: UIViewController {
    /// 页面顶部视图背景色
    var topColor: UIColor {
        get {
            return UIColor.clear
        }
        set {
            topColor = newValue
        }
    }

    /// 页面顶部视图
    var topView: UIView {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: MainScreen.width, height: 64.0)
        view.backgroundColor = topColor
        return view
    }

    /// 状态栏颜色
    var statusColor: UIColor {
        get {
            return UIColor.clear
        }

        set {
            statusColor = newValue
        }
    }

    /// 状态栏
    var statusView: UIView {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 0.0, width: MainScreen.width, height: 20.0)
        view.backgroundColor = statusColor
        return view
    }

    /// 导航栏颜色
    var naviColor: UIColor {
        get {
            return UIColor.clear
        }
        set {
            naviColor = newValue
        }
    }

    /// 导航栏
    var naviView: UIView {
        let view = UIView()
        view.frame = CGRect(x: 0.0, y: 20.0, width: MainScreen.width, height: 44.0)
        view.backgroundColor = naviColor
        view.isUserInteractionEnabled = true
        return view
    }

    /// 构建顶部视图
    func buildTopView() {
        view.addSubview(topView)
        view.addSubview(statusView)
        view.addSubview(naviView)
    }
}

// MARK: 
protocol TopViewWithTitle: TopView {
    /// 标题内容
    var titleString: String { get set }
    /// 标题字体
    var titleFont: UIFont { get set }
    /// 标题文字颜色
    var titleColor: UIColor { get set }
}

extension TopViewWithTitle where Self: UIViewController {
    
    /// 标题内容
    var titleString: String {
        get {
            return ""
        }
        set {
            titleString = newValue
        }
    }

    /// 标题字体
    var titleFont: UIFont {
        get {
            return UIFont.systemFont(ofSize: 12.0)
        }
        set {
            titleFont = newValue
        }
    }

    /// 标题文字颜色
    var titleColor: UIColor {
        get {
            return UIColor.black
        }
        set {
            titleColor = newValue
        }
    }

    /// 显示页面标题的 Label
    var titleLabel: UILabel {
        let titleSize = titleString.rat.size(withFont: titleFont)
        let label = UILabel()
        label.font = titleFont
        label.textColor = titleColor
        label.text = titleString
        label.frame = CGRect(x: (naviView.bounds.width - titleSize.width) / 2.0,
                             y: statusView.bounds.height + (naviView.bounds.height - titleSize.height) / 2,
                             width: titleSize.width,
                             height: titleSize.height)
        return label
    }

    /// 添加页面标题
    func addTitle() {
        self.view.addSubview(titleLabel)
    }
    
}
