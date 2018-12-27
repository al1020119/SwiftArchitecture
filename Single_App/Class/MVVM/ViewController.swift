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
//  ViewController.swift
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class ViewController.swift
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let index = 2
        switch index {
        case 0:
            self.present(NetworkViewController(), animated: true, completion: nil)
        case 1:
            self.present(GameViewController(), animated: true, completion: nil)
        case 2:
            // Override point for customization after application launch.
            let tc = UITabBarController()
            
            let vc1 = TiledMapViewController()
            vc1.mode = TiledContentType.PDF
            vc1.tabBarItem = UITabBarItem(title: "PDF", image: TiledMapStyleKit.image(string: "pdf"), selectedImage: nil)
            
            let vc2 = TiledMapViewController()
            vc2.mode = TiledContentType.Image
            vc2.tabBarItem = UITabBarItem(title: "Image", image: TiledMapStyleKit.image(string: "img"), selectedImage: nil)
            
            tc.viewControllers = [vc1, vc2]
            tc.tabBar.isTranslucent = false
            UIApplication.shared.keyWindow!.rootViewController = tc
            //self.present(tc, animated: true, completion: nil)
        default:
            break
        }
    }
    
}

