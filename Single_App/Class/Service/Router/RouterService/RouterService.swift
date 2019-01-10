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
//  RouterService
//
//  Created by iCocos on 2018/12/22.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class RouterService.swift
// @abstract 路由服务
// @discussion 实现基本的路由控制服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

public class RouterUtilsService {
  //获取当前页面
  public class func currentTopViewController() -> UIViewController? {
    if let rootViewController = UIApplication.shared.keyWindow?.rootViewController{
      return currentTopViewController(rootViewController: rootViewController)
    }else{
      return nil
    }
  }
  
  public class func currentTopViewController(rootViewController: UIViewController) -> UIViewController {
    if (rootViewController.isKind(of: UITabBarController.self)) {
      let tabBarController = rootViewController as! UITabBarController
      return currentTopViewController(rootViewController: tabBarController.selectedViewController!)
    }
    if (rootViewController.isKind(of: UINavigationController.self)) {
      let navigationController = rootViewController as! UINavigationController
      return currentTopViewController(rootViewController: navigationController.visibleViewController!)
    }
    if ((rootViewController.presentedViewController) != nil) {
      return currentTopViewController(rootViewController: rootViewController.presentedViewController!)
    }
    return rootViewController
  }
}

public protocol RouterPathableService {
  var any: AnyClass { get }
  var params: RouterServiceParameter? { get }
}

public typealias  RouterServiceParameter = [String: Any]
public protocol Routable {
  /**
   类的初始化方法
   - params 传参字典
   */
  static func initWithParams(params: RouterServiceParameter?) -> UIViewController
}


open class RouterService {
  
  open class func openTel(_ phone:String) {
    if let url = URL(string: "tel://\(phone)") {
      UIApplication.shared.openURL(url)
    }
  }
  
  open class func open(_ path:RouterPathableService , present: Bool = false , animated: Bool = true , presentComplete: (()->Void)? = nil){
    if let cls = path.any as? Routable.Type {
      let vc = cls.initWithParams(params: path.params)
      vc.hidesBottomBarWhenPushed = true
      let topViewController = RouterUtilsService.currentTopViewController()
      if topViewController?.navigationController != nil && !present {
        topViewController?.navigationController?.pushViewController(vc, animated: animated)
      }else{
        topViewController?.present(vc, animated: animated , completion: presentComplete)
      }
    }
  }
}


