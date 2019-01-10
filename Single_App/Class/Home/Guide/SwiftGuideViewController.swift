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
//  SwiftGuideViewController
//
//  Created by iCocos on 2019/01/02.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftGuideViewController
// @abstract 加载引导页控制器
// @discussion 加载和显示不同类型的引导页控制器
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import UIKit

/// 引导页加载显示控制器
class SwiftGuideViewController: UIViewController {
    
    fileprivate lazy var deskButton: UIButton = {
        let deskButton = UIButton()
        deskButton.setTitle("开始", for: .normal)
        deskButton.setTitleColor(UIColor.black, for: .normal)
        deskButton.setBackgroundColor(.red, forState: .normal)
        deskButton.setTitleColor(UIColor.black, for: .highlighted)
        deskButton.setBackgroundColor(.red, forState: .highlighted)
        deskButton.frame = CGRect.init(x: 100, y: (UIScreen.main.bounds.size.height-60)/2, width: UIScreen.main.bounds.size.width-200, height: 60)
        deskButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        deskButton.titleLabel?.textAlignment = .center
        deskButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return deskButton
    }()
    
    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "首页"
        view.addSubview(deskButton)
        // 静态引导页
        //self.setStaticGuidePage()
        // 动态引导页
        //self.setDynamicGuidePage()
        // 视频引导页
        self.setVideoGuidePage()
    }
    
    /// 移除按钮点击
    ///
    /// - Parameter sender: 移除按钮
    @objc func buttonAction(_ sender: UIButton) {
        print("请先登录操作")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        UIApplication.shared.keyWindow?.rootViewController = vc
    }

    // MARK: - 静态图片引导页
    func setStaticGuidePage() {
        let imageNameArray: [String] = ["guide00", "guide01", "guide02"]
        let guideView = SwiftGuidePageService.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.view.addSubview(guideView)
        guideView.callBackBlock {
            print("----------")
        }
    }
    
    // MARK: - 动态图片引导页
    func setDynamicGuidePage() {
        let imageNameArray: [String] = ["guideImage6.gif", "guideImage7.gif", "guideImage8.gif"]
        let guideView = SwiftGuidePageService.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        //self.navigationController?.view.addSubview(guideView)
        self.view.addSubview(guideView)
    }
    
    // MARK: - 视频引导页
    func setVideoGuidePage() {
        let urlStr = Bundle.main.path(forResource: "guide_video.mp4", ofType: nil)
        let videoUrl = NSURL.fileURL(withPath: urlStr!)
        let guideView = SwiftGuidePageService.init(videoURL:videoUrl, isHiddenSkipButton: false)
        //self.navigationController?.view.addSubview(guideView)
        self.view.addSubview(guideView)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

