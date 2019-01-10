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
//  NetworkViewController
//
//  Created by iCocos on 2019/01/01.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class NetworkViewController.swift
// @abstract 网络调试控制器
// @discussion 实现基本的网络请求调试
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit
import RxSwift

/// 网络调试控制器
class NetworkViewController: UIViewController {
    
    let bag = DisposeBag()
    
    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let va = Variable(1)
        Observable.of(1).bind(to: va).disposed(by: bag)
    }
    
    /// 是否旋转
    override var shouldAutorotate: Bool {
        return true
    }
    
    /// 旋转控制
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
    
    /// 隐藏状态条
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /// 触摸操作
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


