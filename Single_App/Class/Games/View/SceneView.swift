//
//  SceneView.swift
//  SpineSampleProject
//
//  Created by iCocos on 2018/12/25.
//  Copyright © 2018年 Max Gribov. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class SceneView: UIView, NibLoadable {
    
    @IBOutlet weak var sk_view: SKView!
    var scene: GameScene! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .green
        sk_view.backgroundColor = .blue
        presentSceneView()
    }
    
    func presentSceneView() {
        scene = GameScene(size: self.bounds.size)
        scene.scaleMode = .aspectFill
        self.sk_view.presentScene(scene)
    }
    
    func touchAction() {
        
        self.removeFromSuperview()
    }
    
}
