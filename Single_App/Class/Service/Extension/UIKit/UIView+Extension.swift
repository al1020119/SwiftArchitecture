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
//  UIView+Extension.swift
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UIView+Extension.swift
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import UIKit


extension UIView {
    class func view(withFrame frame: CGRect, backgroundColor: UIColor) -> UIView {
        return UIView.init(frame: frame).then(block: { (view) in
            view.backgroundColor = backgroundColor
        })
    }
    
    class func label(withFrame frame: CGRect, text: String?, font: UIFont) -> UILabel {
        return UILabel.init(frame: frame).then(block: { (label) in
            label.text = text
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.white
            label.font = font
        })
    }
    
    /// 多行居中的label
    class func label_WordWrap(withFrame frame: CGRect, text: String?, font: UIFont) -> UILabel {
        return UILabel.init(frame: frame).then(block: { (label) in
            label.text = text
            label.textColor = UIColor.black
            label.backgroundColor = UIColor.white
            label.font = font
            // label.textAlignment = .center
            label.numberOfLines = 0
        })
    }
    
    class func imageView(withFrame frame: CGRect, image: UIImage?) -> UIImageView {
        return UIImageView.init(frame: frame).then(block: { (imageView) in
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = UIColor.white
        })
    }
    
    /// 普通Button
    class func button(withFrame frame: CGRect, title: String?, selectedText: String?, color: UIColor, target: Any?, action: Selector?) -> UIButton {
        return UIButton.init(type: .custom).then(block: { (button) in
            button.frame = frame
            button.isOpaque = true
            button.backgroundColor = color
            if (action != nil) {
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
            // button.showsTouchWhenHighlighted = true
            button.setTitle(title, for: .normal)
            button.setTitle(selectedText, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        })
    }
    
    ///   带背景图片+文字的Button
    class func button(withFrame frame: CGRect, title: String?, selectedTitle: String?, backgroundImage: UIImage?, selectedBgImage: UIImage?, target: Any?, action: Selector?) -> UIButton {
        return UIButton.init(type: .custom).then(block: { (button) in
            button.backgroundColor = UIColor.white
            button.isOpaque = true
            button.frame = frame
            if (action != nil) {
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
            
            button.setTitle(title, for: .normal)
            button.setTitle(selectedTitle, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            
            button.setBackgroundImage(backgroundImage?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.setBackgroundImage(selectedBgImage?.withRenderingMode(.alwaysOriginal), for: .selected)
            button.imageView?.contentMode = .scaleAspectFit
        })
    }
    
    ///   右图左文，大图要改成2x.3x用
    class func button(withFrame frame: CGRect, title: String?, image: UIImage?, titleColor: UIColor, target: Any?, action: Selector?) -> UIButton {
        return UIButton.init(frame: frame).then(block: { (button) in
            button.frame = frame
            button.backgroundColor = UIColor.white
            button.isOpaque = true
            if (action != nil) {
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
            
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            
            button.imageView?.contentMode = .scaleAspectFit
            button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            
            // 开启后图片会高亮
            button.adjustsImageWhenHighlighted = false
            
            // 如果大图要改成2x.3x
            button.contentHorizontalAlignment = .left
            button.titleEdgeInsets = UIEdgeInsets.init(top: 0,
                                                       left: 5,
                                                       bottom: 0,
                                                       right: 0)
            
        })
    }
    
    
    /// 带高亮图片，无文字
    class func button(withFrame frame: CGRect, image: UIImage?, highlightImage: UIImage?, target: Any?, action: Selector?) -> UIButton {
        return UIButton.init(type: .custom).then(block: { (button) in
            button.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            button.setImage(highlightImage?.withRenderingMode(.alwaysOriginal), for: .highlighted)
            button.frame = frame
            button.backgroundColor = UIColor.white
            button.isOpaque = true
            
            if (action != nil) {
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
            button.imageView?.contentMode = .scaleAspectFit
        })
    }
    
    
    ///  带圆角边框的Button
    class func roundedButton(withFrame frame: CGRect, title: String?, titleColor: UIColor?, fillColor: UIColor, borderColor: UIColor, borderRaduis:CGFloat, target: Any?, action: Selector?) -> UIButton {
        return UIButton.init(type: .custom).then(block: { (button) in
            button.frame = frame
            if (action != nil) {
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
            button.imageView?.contentMode = .scaleAspectFit
            
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            
            let image = UIImage.roundingImage(withColor: fillColor,
                                              size: frame.size,
                                              radius: borderRaduis,
                                              borderColor: borderColor,
                                              borderWidth: 1)
            button.setBackgroundImage(image, for: .normal)
        })
    }
    
    /// 圆角按钮，无边框
    class func roundedButton(withFrame frame: CGRect, title: String?, color: UIColor, highlightColor: UIColor?, radius: CGFloat, target: Any?, action: Selector?) -> UIButton {
        return UIButton.init(frame: frame).then(block: { (button) in
            button.frame = frame
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
            
            button.isOpaque = true
            button.backgroundColor = UIColor.white
            
            if (action != nil) {
                button.addTarget(target, action: action!, for: .touchUpInside)
            }
            button.imageView?.contentMode = .scaleAspectFit
            
            let normalImage = UIImage.roundingImage(withColor: color,
                                                    size: frame.size,
                                                    radius: radius)
            let highlightImg = UIImage.roundingImage(withColor: highlightColor!,
                                                     size: frame.size,
                                                     radius: radius)
            button.setBackgroundImage(normalImage, for: .normal)
            button.setBackgroundImage(highlightImg, for: .highlighted)
            
        })
    }
    
    
    // 通用型的圆角按钮，颜色值已定（私用）
    class func universalRoundedButton(withTitle title: String?, horizontalMarginSpace: CGFloat, buttonHeight: CGFloat, originY: CGFloat, target: Any?, action: Selector?) -> UIButton {
        let frame = CGRect.init(x: horizontalMarginSpace,
                                y: originY,
                                width: SingleScreenWidth() - (2 * horizontalMarginSpace),
                                height: buttonHeight)
        return UIButton.roundedButton(withFrame: frame,
                                      title: title,
                                      color: UIColor.RGB(r: 34, g: 194, b: 122)!,
                                      highlightColor: UIColor.RGB(r: 22, g: 152, b: 93),
                                      radius: 8,
                                      target: target, action: action)
    }
    
    ///  通用型圆角按钮，左右边距各15，高度48（私用）
    class func universalRoundedButton(withTitle title: String?, originY: CGFloat, target: Any?, action: Selector?) -> UIButton {
        return UIButton.universalRoundedButton(withTitle: title,
                                               horizontalMarginSpace: 15,
                                               buttonHeight: 48,
                                               originY: originY,
                                               target: target,
                                               action: action)
    }
    
    
    func addBottomLineLayer() -> () {
        let layer = CALayer.init()
        layer.bounds = CGRect.init(x: 0, y: 0, width: self.bounds.size.width,
                                   height: 0.5)
        layer.position = CGPoint.init(x: 0, y: self.bounds.size.height)
        layer.anchorPoint = CGPoint.init(x: 0, y: 1)
        layer.backgroundColor = UIColor.lightGray.alpha(0.5).cgColor
        self.layer.addSublayer(layer)
    }
    
    func addTopLineLayer() -> () {
        let layer = CALayer.init()
        layer.bounds = CGRect.init(x: 0, y: 0, width: self.bounds.size.width,
                                   height: 0.5)
        layer.position = CGPoint.init(x: 0, y: 0)
        layer.anchorPoint = CGPoint.init(x: 0, y: 0)
        layer.backgroundColor = UIColor.lightGray.alpha(0.5).cgColor
        self.layer.addSublayer(layer)
    }
}
