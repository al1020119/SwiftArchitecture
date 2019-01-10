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
//  GameViewController
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class GameViewController.swift
// @abstract 游戏控制器操作
// @discussion 实现和显示游戏立绘控制器显示
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

import SpriteKit
import GameplayKit

/// 游戏控制器操作
class GameViewController: UIViewController {
    
    var scene: SceneView!
    
    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        scene = SceneView.loadFromNib()
        scene.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        self.view.addSubview(scene)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "d返回", style: .done, handler: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    /// 触摸操作
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.scene.frame = CGRect(x: 150, y: 250, width: 200, height: 200)
        }) { [weak self] (isfinish1) in
            UIView.animate(withDuration: 1, animations: { [weak self] in
                self?.scene.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
            }, completion: { [weak self] (isfinish2) in
                UIView.animate(withDuration: 1, animations: { [weak self] in
                    self?.scene.frame = CGRect(x: 150, y: 350, width: 200, height: 200)
                }, completion: {  [weak self] (isfinish) in
                    self?.scene.touchAction()
                })
            })
        }
    }
    
    /// 弹出立绘场景View
    func presentSceneView() {
        if let view = self.view as! SKView? {
            let scene = GameScene(size: self.view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            //debug info
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsDrawCount = true
        }
    }
    
//    /// 是否需要旋转
//    override var shouldAutorotate: Bool {
//        return true
//    }
//
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
    
//    /// 隐藏状态栏
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
}

