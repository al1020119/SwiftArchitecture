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
//  RouterSwift
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class RouterSwift.swift
// @abstract 路由控制
// @discussion 实现基本的路由跳转和控制
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

struct RouterSwiftDic {
    var moduleID: Int
    var className: String
    var params: Dictionary<String, Any>
}

extension RouterSwift {
    class func openUrl(url: String) -> Bool {
        LPrint("url 有误")
        // 验证 url 的合法性,解析 url 数据
        guard let urlParams = RouterSwift.getRouterParams(urlStr: url) else {
            return false
        }

        guard let scheme = urlParams.scheme else {
            return false
        }
        if !routeProtocl.contains(scheme) {
            LPrint("路由不支持协议\(String(describing: urlParams.scheme))")
            return false
        }
        if urlParams.scheme == "http" || urlParams.scheme == "https" {
            if let urlreal = URL.init(string: url) {
                UIApplication.shared.openURL(urlreal)
                return true
            } else {
                LPrint("url 有误")
                return false
            }
        }

        guard let moduleId = urlParams.moduleId else {
            LPrint("没有定义相关的 moduleId")
            return false
        }
        let routeConfig = RouterSwift.instance().getRouterSwiftDicFromModuleId(moduleId: moduleId)
        guard let className = routeConfig?.className, let domainName = urlParams.domainName else {
            return false
        }

        return RouterSwift.openController(domainName: domainName, className: className, params: urlParams.params)

    }
    class func openController(moduleId: Int, params: Dictionary<String, Any>) -> Bool {

        guard let vc = RouterSwift.createViewController(moduleId: moduleId, params: params) else {
            return false
        }
        guard let currentVC = RouterHelper.getCurrentNavController() else {
            return false
        }
        guard let nav = currentVC.navigationController else {
            currentVC.present(vc, animated: true, completion: nil)
            return true
        }
        nav.pushViewController(vc, animated: true)
        return true
    }
    class func openController(domainName: String, className: String, params: Dictionary<String, Any>) -> Bool {

        guard let vc = RouterSwift.createViewController(domainName: domainName, className: className, params: params) else {
            return false
        }
        guard let currentVC = RouterHelper.getCurrentNavController() else {
            return false
        }
        guard let nav = currentVC.navigationController else {
            currentVC.present(vc, animated: true, completion: nil)
            return true
        }
        nav.pushViewController(vc, animated: true)
        return true
    }
    class func openController(className: String, params: Dictionary<String, Any>) -> Bool {

        return RouterSwift.openController(domainName: myDomain, className: className, params: params)
    }
}

// 修改此处就可以 不同域名中的 跳转
let myDomain = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
let supportDomains = ["RouterProject"]
let routeProtocl = ["routeprotocol", "http", "https"]

private let router: RouterSwift = {
    let router = RouterSwift()
    router.reloadRawData()
    return router
}()

class RouterSwift: NSObject {

    class func instance() -> RouterSwift {
        return router
    }

    // 初始化数据
    var classNameDic: Dictionary<String, RouterSwiftDic> = [:]
    var moduleIdDic: Dictionary<Int, RouterSwiftDic> = [:]

    fileprivate func reloadRawData() {
        let rawData = RouterSwift.getRouterConfig()
        classNameDic = rawData.classNameDic
        moduleIdDic = rawData.moduleIdDic
    }

    // 创建路由表
    fileprivate class func getRouterConfig() -> (classNameDic: Dictionary<String, RouterSwiftDic>, moduleIdDic: Dictionary<Int, RouterSwiftDic>) {
        var classNameDic: Dictionary<String, RouterSwiftDic> = [:]
        var moduleIdDic: Dictionary<Int, RouterSwiftDic> = [:]
        let array: [Dictionary<String, Any>] = RouterSwift.getConfigDicFromJson(jsonArray: ["router_modules.json"])

        for arrayItem in array {
            guard let moduleId = arrayItem["moduleID"] as? Int, let className = arrayItem["targetVC"] as? String else {
                continue
            }
            let params: Dictionary<String, Any> = arrayItem["params"] as! Dictionary<String, Any>
            let routerDic = RouterSwiftDic(moduleID: moduleId, className: className, params: params)
            classNameDic.merge([routerDic.className: routerDic]) { (first, _) -> RouterSwiftDic in
                return first
            }
            moduleIdDic.merge([routerDic.moduleID: routerDic]) { (first, _) -> RouterSwiftDic in
                return first
            }
        }
        return (classNameDic, moduleIdDic)
    }

    fileprivate class func getRouterParams(urlStr: String) -> (scheme: String?, domainName: String?, moduleId: Int?, params: Dictionary<String, String>)? {
        let url = URL.init(string: urlStr)
        let scheme = url?.scheme // http
        let domainName = url?.host // www.baidu.com
        let paramStr = url?.query   // 后面的参数
        let moduleId = url?.port
        let params = RouterSwift.getDicFromURlQuery(query: paramStr)
        return (scheme, domainName, moduleId, params)
    }

    fileprivate class func getDicFromURlQuery(query: String?) -> Dictionary<String, String> {
        var paramDic: Dictionary<String, String> = [:]
        guard let parameterArr = query?.components(separatedBy: "&") else {
            return paramDic
        }
        for paramStr in parameterArr {
            let body = paramStr.components(separatedBy: "=")
            if body.count == 2 {
                paramDic.merge([body[0]: body[1]]) { (_, v1) -> String in
                    return v1
                }
            }
        }
        return paramDic
    }

    fileprivate func getRouterSwiftDicFromModuleId(moduleId: Int) -> RouterSwiftDic? {
        let className: RouterSwiftDic? = nil
        let allKeys = moduleIdDic.keys
        if allKeys.contains(moduleId) {
            return moduleIdDic[moduleId]
        }
        return className
    }

    fileprivate class func cheackParams(className: String, params: Dictionary<String, Any>) -> Bool {

        let classNameDic = RouterSwift.instance().classNameDic
        let dic = classNameDic
        let dicAllKey = dic.keys
        let isContain = dicAllKey.contains(className)
        if isContain == false {
            LPrint("没有要初始化的配置资源\(className)")
            return false
        }
        if let allNeedParams: Dictionary<String, Any> = dic[className]?.params {
            for v in allNeedParams.keys {
                let flag = params.keys.contains(v)
                if flag == false { return false }
            }
        }
        return true
    }

    fileprivate class func createViewController(moduleId: Int, params: Dictionary<String, Any>) -> UIViewController? {
        let moduleIdArray = RouterSwift.instance().moduleIdDic.keys
        if moduleIdArray.contains(moduleId), let moduleDic = RouterSwift.instance().moduleIdDic[moduleId] {

            return RouterSwift.createViewController(className: moduleDic.className, params: params)
        }
        return nil
    }

    fileprivate class func createViewController(domainName: String, className: String, params: Dictionary<String, Any>) -> UIViewController? {
        let flag = RouterSwift.cheackParams(className: className, params: params)
        if flag == false { return nil}
        var currentDomainName: String = domainName
        if !supportDomains.contains(domainName) {   // 更正 需要的域名
            if let index = supportDomains.findIndex(item: domainName) {
                currentDomainName = supportDomains[index]
            } else {
                LPrint("没有找到相关的域名")
            }
        }
        guard let cls: AnyClass = NSClassFromString(currentDomainName + "." + className) else {
            return nil
        }
        guard let realClass = cls as? AutoCreateProtocol.Type else {
            return nil
        }
        let object: UIViewController = realClass.init(params: params) as! UIViewController
        return object
    }

    fileprivate class func createViewController(className: String, params: Dictionary<String, Any>) -> UIViewController? {
       let object = RouterSwift.createViewController(domainName: myDomain, className: className, params: params)
        return object
    }
    fileprivate class func getConfigDicFromJson(jsonArray: Array<String>) -> [Dictionary<String, Any>] {
        var configArray: [Dictionary<String, Any>] = []

        for fileName in jsonArray {
            if let path = Bundle.main.path(forResource: fileName, ofType: nil) {
                let pathUrl = URL.init(fileURLWithPath: path)
                do {
                    let data = try Data.init(contentsOf: pathUrl)
                    if let arr: [Dictionary<String, Any>] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Dictionary<String, Any>] {
                        configArray = arr
                    }
                } catch {
                    continue
                }
            }

        }
        return configArray

    }
}
