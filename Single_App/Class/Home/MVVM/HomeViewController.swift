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
//  HomeViewController.swift
//
//  Created by iCocos on 2018/12/27.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class HomeViewController.swift
// @abstract 控制器操作
// @discussion 首页基本控制操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit
import SQLite
import SwiftyUserDefaults
import Closures

/// 控制器操作
class HomeViewController: UIViewController {
    
    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UIDevice.isSimulator {
            
            print("---------------------statusBarInfo-------------------------\n")
            print(AppConfigInfo.statusBarInfo())
            
            print("---------------------serviceCompany------------------------\n")
            print(AppConfigInfo.serviceCompany())
            print("---------------------currentNetworkType--------------------\n")
            print(AppConfigInfo.currentNetworkType())
            print("--------------------currentBatteryPercent------------------\n")
            print(AppConfigInfo.currentBatteryPercent())
            
            print("---------------------currentTimeString---------------------\n")
            print(AppConfigInfo.currentTimeString())
            
            print("---------------------currentDataString---------------------\n")
            print(AppConfigInfo.currentDataWeekString())
            
            print("-----------------------------------------------------------\n")
        }
        
        Defaults[.uid] = "1119"
        Defaults[.username] = "iCocos"
        
        
        print(Defaults[.uid] ?? "")
        print(Defaults[.username] ?? "")
        
        
        self.title = "Single-App"
        
        //保存
        let product = AccountModel()
        product.name = "iPhone 7"
        product.price = NSNumber(value:599)
        try! product.save()
        
        //查询
        let p1 = AccountModel.findFirst("name",value:"iPhone")
        print(p1 ?? "")
        //or
        let name = Expression<String>("name")
        let p2 = AccountModel.findAll(name == "iPhone").first
        //id = 1, name = iPhone 7, price = 599, desc = nil,  publish_date = nil, created_at = 1498616987587.237, updated_at = 1498616987587.237,
        
        //更新
        p2?.name = "iPad"
        try! p2?.update()
        
        //删除
        try! p2?.delete()
        
    }
    
//    /// 是否需要旋转
//    override var shouldAutorotate: Bool {
//        return true
//    }
    
//    /// 旋转操作
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /// js操作
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func jsCoreAction(_ sender: UIButton) {
        let vc = JSWebViewController()
        vc.title = sender.currentTitle
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 碎片地图
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func tiledmapAntion(_ sender: UIButton) {
        let vc = TiledMapViewController()
        vc.mode = TiledContentType.Image
        vc.title = sender.currentTitle
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 立绘显示
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func roleCoverAction(_ sender: UIButton) {
        let vc = GameViewController()
        vc.title = sender.currentTitle
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 音频播放
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func audioAction(_ sender: UIButton) {
        let vc = AudioPlayerViewController()
        vc.title = sender.currentTitle
        self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 手机页
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func guideViewAction(_ sender: UIButton) {
        let vc = DestktopViewController()
        vc.title = sender.currentTitle
        self.present(vc, animated: true, completion: nil)
    }
    
    
    /// 触摸操作
    //override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //    let index = 2
    //    switch index {
    //    case 0:
    //        self.present(NetworkViewController(), animated: true, completion: nil)
    //    case 1:
    //        self.present(GameViewController(), animated: true, completion: nil)
    //    case 2:
    //        // Override point for customization after application launch.
    //        let tc = UITabBarController()
    //
    //        let vc1 = TiledMapViewController()
    //        vc1.mode = TiledContentType.PDF
    //        vc1.tabBarItem = UITabBarItem(title: "PDF", image: TiledMapStyleKit.image(string: "pdf"), selectedImage: nil)
    //
    //        let vc2 = TiledMapViewController()
    //        vc2.mode = TiledContentType.Image
    //        vc2.tabBarItem = UITabBarItem(title: "Image", image: TiledMapStyleKit.image(string: "img"), selectedImage: nil)
    //
    //        tc.viewControllers = [vc1, vc2]
    //        tc.tabBar.isTranslucent = false
    //        UIApplication.shared.keyWindow!.rootViewController = tc
    //        //self.present(tc, animated: true, completion: nil)
    //    default:
    //        break
    //    }
    //}

}

