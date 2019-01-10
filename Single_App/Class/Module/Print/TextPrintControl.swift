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
//  TextPrintControl
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class TextPrintControl.swift
// @abstract 文本打印组件
// @discussion 实现内容文本打印效果
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

/*
 在运行时设置文本以触发类型动画；
 

 为每个字符之间的间隔时间设置charinterval属性，默认为0.1；
 
 调用pausetyping（）暂停动画；
 
 调用ContinueType（）以继续暂停的动画；
 */


/// 文本打印组件
@IBDesignable open class TextPrintControl: UILabel {
    /*
     设置每个字符之间的间隔时间
     */
    @IBInspectable open var charInterval: Double = 0.1

    /*
     键入动画完成时激发的可选处理程序
     */
    open var onTypingAnimationFinished: (() -> Void)?
    
    /*
     如果文本在键入时始终居中
     */
    @IBInspectable open var centerText: Bool = true
    
    private var typingStopped: Bool = false
    private var typingOver: Bool = true
    private var stoppedSubstring: String?
    private var attributes: [NSAttributedString.Key: Any]?
    private var currentDispatchID: Int = 320
    private let dispatchSerialQ = DispatchQueue(label: "TextPrintControl")
    /*
     设置属性化文本将自动触发动画
     */
    override open var text: String! {
        get {
            return super.text
        }
        set {
            if charInterval < 0 {
                charInterval = -charInterval
            }
            currentDispatchID += 1
            typingStopped = false
            typingOver = false
            stoppedSubstring = nil
            
            attributes = nil
            setTextWithTypingAnimation(newValue, attributes,charInterval, true, currentDispatchID)
        }
    }
    
    /*
     设置属性化文本将自动触发动画
     */
    override open var attributedText: NSAttributedString! {
        get {
            return super.attributedText
        }
        set {
            if charInterval < 0 {
                charInterval = -charInterval
            }
            currentDispatchID += 1
            typingStopped = false
            typingOver = false
            stoppedSubstring = nil
            
            attributes = newValue.attributes(at: 0, effectiveRange: nil)
            setTextWithTypingAnimation(newValue.string, attributes,charInterval, true, currentDispatchID)
        }
    }
    
    // MARK: 暂停打印动画
    
    open func pauseTyping() {
        if typingOver == false {
            typingStopped = true
        }
    }
    
    // MARK: 继续打印动画
    
    open func continueTyping() {
        
        guard typingOver == false else {
            print("TextPrintControl: Animation is already over")
            return
        }
        
        guard typingStopped == true else {
            print("TextPrintControl: Animation is not stopped")
            return
        }
        guard let stoppedSubstring = stoppedSubstring else {
            return
        }
        
        typingStopped = false
        setTextWithTypingAnimation(stoppedSubstring, attributes ,charInterval, false, currentDispatchID)
    }
    
    // MARK: 设置文本打印递归循环
    
    private func setTextWithTypingAnimation(_ typedText: String, _ attributes: Dictionary<NSAttributedString.Key, Any>?, _ charInterval: TimeInterval, _ initial: Bool, _ dispatchID: Int) {
        
        guard typedText.count > 0 && currentDispatchID == dispatchID else {
            typingOver = true
            typingStopped = false
            if let nonNilBlock = onTypingAnimationFinished {
                DispatchQueue.main.async(execute: nonNilBlock)
            }
            return
        }
        
        guard typingStopped == false else {
            stoppedSubstring = typedText
            return
        }
        
        if initial == true {
            super.text = ""
        }
        
        let firstCharIndex = typedText.index(typedText.startIndex, offsetBy: 1)
        
        DispatchQueue.main.async {
            if let attributes = attributes {
                super.attributedText = NSAttributedString(string: super.attributedText!.string +  String(typedText[..<firstCharIndex]),
                                                          attributes: attributes)
            } else {
                super.text = super.text! + String(typedText[..<firstCharIndex])
            }
            
            if self.centerText == true {
                self.sizeToFit()
            }
            self.dispatchSerialQ.asyncAfter(deadline: .now() + charInterval) { [weak self] in
                let nextString = String(typedText[firstCharIndex...])
                
                self?.setTextWithTypingAnimation(nextString, attributes, charInterval, false, dispatchID)
            }
        }
        
    }
}
