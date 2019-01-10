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
//  GameScene
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class GameScene.swift
// @abstract 游戏场景
// @discussion 实现基本的游戏场景和立绘显示
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import SpriteKit
import GameplayKit
import Spine

/// 游戏场景
class GameScene: SKScene {
    
    /// View显示完毕，且frame完成
    ///
    /// - Parameter view: 场景View
    override func didMove(to view: SKView) {
        
        if let character = Skeleton(fromJSON: "goblins-ess", atlas: "Goblins", skin: "goblin"){
            
            character.name = "character"
            character.position = CGPoint(x: self.size.width / 2, y: (self.size.height / 2) - 200)
            
            self.addChild(character)
            
            if let walkAnimation = character.animation(named: "walk") {
                
                character.run(SKAction.repeatForever(walkAnimation))
            }
        }
    }
}
