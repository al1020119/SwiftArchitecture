//
//  Router.swift
//  SwiftDemo
//
//  Created by phoenix on 2018/11/29.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

struct RouterDic {
    var moduleID: Int
    var className: String
    var params: Dictionary<String, Any>
}
extension Router {
    class func openUrl(url: String) -> Bool {
        LPrint("url 有误")
        // 验证 url 的合法性,解析 url 数据
        guard let urlParams = Router.getRouterParams(urlStr: url) else {
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
        let routeConfig = Router.instance().getRouterDicFromModuleId(moduleId: moduleId)
        guard let className = routeConfig?.className, let domainName = urlParams.domainName else {
            return false
        }

        return Router.openController(domainName: domainName, className: className, params: urlParams.params)

    }
    class func openController(moduleId: Int, params: Dictionary<String, Any>) -> Bool {

        guard let vc = Router.createViewController(moduleId: moduleId, params: params) else {
            return false
        }
        guard let currentVC = RHelper.getCurrentNavController() else {
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

        guard let vc = Router.createViewController(domainName: domainName, className: className, params: params) else {
            return false
        }
        guard let currentVC = RHelper.getCurrentNavController() else {
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

        return Router.openController(domainName: myDomain, className: className, params: params)
    }
}

// 修改此处就可以 不同域名中的 跳转
let myDomain = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
let supportDomains = ["RouterProject"]
let routeProtocl = ["routeprotocol", "http", "https"]

private let router: Router = {
    let router = Router()
    router.reloadRawData()
    return router
}()

class Router: NSObject {

    class func instance() -> Router {
        return router
    }

    // 初始化数据
    var classNameDic: Dictionary<String, RouterDic> = [:]
    var moduleIdDic: Dictionary<Int, RouterDic> = [:]

    fileprivate func reloadRawData() {
        let rawData = Router.getRouterConfig()
        classNameDic = rawData.classNameDic
        moduleIdDic = rawData.moduleIdDic
    }

    // 创建路由表
    fileprivate class func getRouterConfig() -> (classNameDic: Dictionary<String, RouterDic>, moduleIdDic: Dictionary<Int, RouterDic>) {
        var classNameDic: Dictionary<String, RouterDic> = [:]
        var moduleIdDic: Dictionary<Int, RouterDic> = [:]
        let array: [Dictionary<String, Any>] = Router.getConfigDicFromJson(jsonArray: ["modules.json"])

        for arrayItem in array {
            guard let moduleId = arrayItem["moduleID"] as? Int, let className = arrayItem["targetVC"] as? String else {
                continue
            }
            let params: Dictionary<String, Any> = arrayItem["params"] as! Dictionary<String, Any>
            let routerDic = RouterDic(moduleID: moduleId, className: className, params: params)
            classNameDic.merge([routerDic.className: routerDic]) { (first, _) -> RouterDic in
                return first
            }
            moduleIdDic.merge([routerDic.moduleID: routerDic]) { (first, _) -> RouterDic in
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
        let params = Router.getDicFromURlQuery(query: paramStr)
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

    fileprivate func getRouterDicFromModuleId(moduleId: Int) -> RouterDic? {
        let className: RouterDic? = nil
        let allKeys = moduleIdDic.keys
        if allKeys.contains(moduleId) {
            return moduleIdDic[moduleId]
        }
        return className
    }

    fileprivate class func cheackParams(className: String, params: Dictionary<String, Any>) -> Bool {

        let classNameDic = Router.instance().classNameDic
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
        let moduleIdArray = Router.instance().moduleIdDic.keys
        if moduleIdArray.contains(moduleId), let moduleDic = Router.instance().moduleIdDic[moduleId] {

            return Router.createViewController(className: moduleDic.className, params: params)
        }
        return nil
    }

    fileprivate class func createViewController(domainName: String, className: String, params: Dictionary<String, Any>) -> UIViewController? {
        let flag = Router.cheackParams(className: className, params: params)
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
       let object = Router.createViewController(domainName: myDomain, className: className, params: params)
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
