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
//  SceneView
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class SceneView.swift
// @abstract 场景View
// @discussion 实现和显示游戏场景
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit
import SpriteKit
import GameplayKit

/// 场景View
class SceneView: UIView, SwiftNibable {
    
    @IBOutlet weak var sk_view: SKView!
    var scene: GameScene! = nil
    
    /// 初始化
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .green
        sk_view.backgroundColor = .blue
        presentSceneView()
    }
    
    /// 弹出场景控件
    func presentSceneView() {
        scene = GameScene(size: self.bounds.size)
        scene.scaleMode = .aspectFill
        self.sk_view.presentScene(scene)
    }
    
    /// 点击操作
    func touchAction() {
        self.removeFromSuperview()
    }
    
}
