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
//  TextPrintViewController
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class TextPrintViewController.swift
// @abstract 文本打印控制器
// @discussion 实现内容文本打印显示与控制逻辑
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

/// 文本打印控制器
class TextPrintViewController: UIViewController {
    
    @IBOutlet weak var demoLabel: TextPrintControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoLabel.charInterval = 0.1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Set Text
        demoLabel.textAlignment = .left
        demoLabel.numberOfLines = 0
        demoLabel.sizeToFit()
        demoLabel.textColor = .white
        demoLabel.font = UIFont.systemFont(ofSize: 16)
        demoLabel.text = "This is a demo of a typing label animation.This is a demo of a typing label animation.This is a demo of a typing label animation.This is a demo of a typing label animation"
        demoLabel.onTypingAnimationFinished = { [unowned self] in
            self.showSampleAlert()
        }
    }

    fileprivate func showSampleAlert() {
        let sampleAlert = UIAlertController(title: "Sample", message: "Typing animation finished!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        sampleAlert.addAction(okAction)
        self.present(sampleAlert, animated: true, completion: nil)
    }
    
    /// 暂停打印
    ///
    /// - Parameter sender: 按钮
    @IBAction func stopTapped(_ sender: AnyObject) {
        demoLabel.pauseTyping()
    }
    
    /// 继续打印
    ///
    /// - Parameter sender: 按钮
    @IBAction func continueTapped(_ sender: AnyObject) {
        demoLabel.continueTyping()
    }
    
    var showNoramlText = false
    
    /// 重新打印
    ///
    /// - Parameter sender: 按钮
    @IBAction func restartTapped(_ sender: AnyObject) {
        if( showNoramlText) { //Plain Text Sample
            demoLabel.text = "This is a demo of a typing label animation.This is a demo of a typing label animation.This is a demo of a typing label animation.This is a demo of a typing label animation"
        } else { //Attributed Text Sample
            let attr = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.strokeColor: UIColor.white, NSAttributedString.Key.strokeWidth: -3] as [NSAttributedString.Key : Any]
            demoLabel.attributedText = NSAttributedString(string: "This is a demo of a typing label animation.This is a demo of a typing label animation.This is a demo of a typing label animation.This is a demo of a typing label animation", attributes: attr)
        }
        showNoramlText = !showNoramlText
    }
}

