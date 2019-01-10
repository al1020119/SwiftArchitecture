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
//  JSWebViewController
//
//  Created by iCocos on 2019/01/02.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class JSWebViewController.swift
// @abstract JS交互控制器
// @discussion 实现JS交互控制跳转
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import UIKit

/// JS交互控制器
class JSWebViewController: UIViewController {
    
    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(nextBtn)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "d返回", style: .done, handler: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 跳转按钮
    lazy var nextBtn = { () -> UIButton in
        let nextBtn = UIButton.init(frame: CGRect(x: 100, y: 100, width: 300, height: 100))
        nextBtn.setTitle("跳转到 WebView", for: .normal)
        nextBtn.setTitleColor(.black, for: .normal)
        nextBtn.addTarget(self, action: #selector(clickNextBtn(sender:)), for: .touchUpInside)
        return nextBtn
    }()
    
}

// MARK: - JS交互控制器分类拓展
extension JSWebViewController{
    
    /// 跳转按钮点击
    ///
    /// - Parameter sender: 跳转按钮
    @objc func clickNextBtn(sender:UIButton){
        navigationController?.pushViewController(SwiftJavaScriptService(), animated: true)
    }
    
}



