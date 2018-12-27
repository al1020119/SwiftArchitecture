
//
//  NetworkViewController.swift
//  Single_App
//
//  Created by iCocos on 2018/12/25.
//  Copyright © 2018年 iCocos. All rights reserved.
//

import UIKit
import RxSwift

class NetworkViewController: UIViewController {
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let va = Variable(1)
        Observable.of(1).bind(to: va).disposed(by: bag)
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
        let index = 0
        switch index {
        case 0:
            NetworkingHandler
                .request(.loadCarBrand)
                .mapModels(Model.self)
                .mapSectionModel("", type: Model.self)
                .subscribe(onNext: { (model) in
                    
                }, onError: { (error) in
                })
                .disposed(by: bag)
        case 1:
            //CoreDataManager.shared.save(model: Cache.self, content: { (cache) in
            //    cache?.url = "123123"
            //    cache?.timeStamp = 41236741241
            //    cache?.response = Data()
            //}, success: {
            //    print("保存成功")
            //}) { (_) in
            //    print("保存失败")
            //}
            break
        case 2:
            //CoreDataManager.shared.fetch(table: Cache.self, fetchRequestContent: { (request) in
            //
            //}, predicate: { () -> NSPredicate in
            //    return NSPredicate(format: "url= '123123' ", "")
            //}, success: { (array) in
            //    for cache in array {
            //        print(cache.timeStamp)
            //    }
            //}) { (_) in
            //
            //}
            break
        default:
            break
        }
        
        
        
    }
    
}


