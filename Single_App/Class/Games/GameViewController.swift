//
//  GameViewController.swift
//  Single_App
//
//  Created by iCocos on 2018/12/25.
//  Copyright © 2018年 iCocos. All rights reserved.
//

import UIKit

import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene: SceneView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        scene = SceneView.loadFromNib()
        scene.frame = CGRect(x: 100, y: 200, width: 200, height: 200)
        self.view.addSubview(scene)
    }
    
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
    
}

