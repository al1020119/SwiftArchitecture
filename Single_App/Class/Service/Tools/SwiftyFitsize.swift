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
//  SwiftyFitsize
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftyFitsize.swift
// @abstract 大小适配
// @discussion 实现宽高比例大小适配
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

@objc public enum SwiftyFitType: Int {
    /// Original Value
    case none = 0
    /// ~
    case flexible = 1
    /// ≈
    case force = 2
}

/// 屏幕宽度
fileprivate let ScreenW = UIScreen.main.bounds.width

/// 适配大小
public final class SwiftyFitsize {
    static let shared = SwiftyFitsize()
    private init() { }
    
    /// 默认参照宽度
    private var referenceW: CGFloat = 375
    /// 默认 iPad 适配缩放倍数 (0 , 1]
    private var iPadFitMultiple: CGFloat = 0.5
    
    /// 设置参照的相关参数
    ///
    /// - Parameters:
    ///   - width: 参照的宽度
    ///   - iPadFitMultiple: iPad 在适配后所得值的倍数 (0 , 1]
    public static func reference(
        width: CGFloat,
        iPadFitMultiple: CGFloat
    ) {
        SwiftyFitsize.shared.referenceW = width
        SwiftyFitsize.shared.iPadFitMultiple =
            (iPadFitMultiple > 1 || iPadFitMultiple < 0) ? 1 : iPadFitMultiple
    }
    
    /// 适配字体大小
    ///
    /// - Parameters:
    ///   - value: 大小值
    ///   - fitType: 适配类型
    /// - Returns: 适配比例
    fileprivate func fitNumberSize(
        _ value: CGFloat,
        fitType: SwiftyFitType
    ) -> CGFloat {
        switch fitType {
        case .none: return value
        case .flexible:
            return ScreenW / referenceW * value *
                (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
                    ? SwiftyFitsize.shared.iPadFitMultiple : 1)
        case .force: return ScreenW / referenceW * value
        }
    }
    
    /// 适配字体大小
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - type: 适配类型
    /// - Returns: 字体对象
    fileprivate func fitFontSize(
        _ font : UIFont,
        type: SwiftyFitType
    ) -> UIFont {
        switch type {
        case .flexible: return font~
        case .force: return font≈
        default: return font
        }
    }
}

// MARK:- SwiftyFitsize
/*
 * ~ : 当设备为iPad时，适配后的 value 会再乘上 iPadFitMultiple
 * ≈ : 强制适配，不论是iPhone还是iPad 都不会乘上 iPadFitMultiple
 */

// MARK: operator ~
postfix operator ~
public postfix func ~ (value: CGFloat) -> CGFloat {
    return SwiftyFitsize.shared.fitNumberSize(value, fitType: .flexible)
}

public postfix func ~ (font: UIFont) -> UIFont {
    return UIFont(name: font.fontName, size: font.pointSize~) ?? font
}

public postfix func ~ (value: Int) -> CGFloat {
    return CGFloat(value)~
}

public postfix func ~ (value: Float) -> CGFloat {
    return CGFloat(value)~
}

public postfix func ~ (value: CGPoint) -> CGPoint {
    return CGPoint(
        x: value.x~,
        y: value.y~
    )
}

public postfix func ~ (value: CGSize) -> CGSize {
    return CGSize(
        width: value.width~,
        height: value.height~
    )
}

public postfix func ~ (value: CGRect) -> CGRect {
    return CGRect(
        x: value.origin.x~,
        y: value.origin.y~,
        width: value.size.width~,
        height: value.size.height~
    )
}

public postfix func ~ (value: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(
        top: value.top~,
        left: value.left~,
        bottom: value.bottom~,
        right: value.right~
    )
}

// MARK: operator ≈
postfix operator ≈
public postfix func ≈ (value: CGFloat) -> CGFloat {
    return SwiftyFitsize.shared.fitNumberSize(value, fitType: .force)
}

public postfix func ≈ (font: UIFont) -> UIFont {
    return UIFont(name: font.fontName, size: font.pointSize≈) ?? font
}

public postfix func ≈ (value: Int) -> CGFloat {
    return CGFloat(value)≈
}

public postfix func ≈ (value: Float) -> CGFloat {
    return CGFloat(value)≈
}

public postfix func ≈ (value: CGPoint) -> CGPoint {
    return CGPoint(
        x: value.x≈,
        y: value.y≈
    )
}

public postfix func ≈ (value: CGSize) -> CGSize {
    return CGSize(
        width: value.width≈,
        height: value.height≈
    )
}

public postfix func ≈ (value: CGRect) -> CGRect {
    return CGRect(
        x: value.origin.x≈,
        y: value.origin.y≈,
        width: value.size.width≈,
        height: value.size.height≈
    )
}

public postfix func ≈ (value: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(
        top: value.top≈,
        left: value.left≈,
        bottom: value.bottom≈,
        right: value.right≈
    )
}

// MARK:- Xib/Storyboard
public extension NSLayoutConstraint {
    @IBInspectable var swiftyFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType.init(rawValue: newValue) else { return }
            constant =  SwiftyFitsize.shared.fitNumberSize(constant, fitType: type)
        }
    }
}

// MARK: - UILabel字体适配
public extension UILabel {
    @IBInspectable var fontFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType.init(rawValue: newValue) else { return }
            guard let xfont = font else { return }
            self.font =  SwiftyFitsize.shared.fitFontSize(xfont, type: type)
        }
    }
}

// MARK: - UITextView字体适配
public extension UITextView {
    @IBInspectable var fontFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType.init(rawValue: newValue) else { return }
            guard let xfont = font else { return }
            self.font =  SwiftyFitsize.shared.fitFontSize(xfont, type: type)
        }
    }
}

// MARK: - UITextFiled字体适配
public extension UITextField {
    @IBInspectable var fontFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType.init(rawValue: newValue) else { return }
            guard let xfont = font else { return }
            self.font =  SwiftyFitsize.shared.fitFontSize(xfont, type: type)
        }
    }
}

// MARK: - UIButton字体适配
public extension UIButton {
    @IBInspectable var fontFitType: Int {
        get { return SwiftyFitType.none.rawValue }
        set {
            guard let type = SwiftyFitType.init(rawValue: newValue) else { return }
            guard let xfont = titleLabel?.font else { return }
            self.titleLabel?.font =  SwiftyFitsize.shared.fitFontSize(xfont, type: type)
        }
    }
}


