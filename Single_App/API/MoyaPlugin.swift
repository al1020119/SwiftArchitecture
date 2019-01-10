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
//  MoyaPlugin
//
//  Created by iCocos on 2018/12/25.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class MoyaPlugin.swift
// @abstract Moya拓展支持
// @discussion 提供请求Moya操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import Moya
import SwiftyJSON
import Result

/// Moya插件: 网络请求时显示loading...
internal final class SingleShowState: PluginType {
    
    /// 在发送之前调用来修改请求
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.timeoutInterval = 15 //超时时间
        return request
    }
    
    /// 在通过网络发送请求(或存根)之前立即调用
    func willSend(_ request: RequestType, target: TargetType) {
        // guard let target = target as? APIService else { return }
        /// 判断是否需要显示: 网络请求之前，显示对应的进度条
        // target.showStats ? SVProgressHUD.show() : ()
        // SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    /// 在收到响应之后调用，但是在MoyaProvider调用它的完成处理程序之前调用
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        /// 0.2s后消失：网络请求之后，移除进度条
        // SVProgressHUD.dismiss(withDelay: 0.2)
    }
    
    /// 调用以在完成之前修改结果
    //func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {}
    
}

/// Moya插件: 控制台打印请求的参数和服务器返回的json数据
internal final class SLPrintParameterAndJson: PluginType {
    
    /// 发生请求
    ///
    /// - Parameters:
    ///   - request: 请求类型
    ///   - target: 目标类型
    func willSend(_ request: RequestType, target: TargetType) {
        #if DEBUG
        print("""
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            请求参数=====> \(target)
            """)
        #endif
    }
    
    /// 接受数据
    ///
    /// - Parameters:
    ///   - result: 结果
    ///   - target: 目标类型
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        #if DEBUG
        switch result {
        case .success(let response):
            do {
                let jsonObiect = try response.mapJSON()
                print("""
                    请求成功=====> \(target)
                    \(JSON(jsonObiect))
                    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                    """)
            } catch {
                print("""
                请求成功=====> \(target)
                无返回数据
                <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                """)
            }
            break
        default:
            print("""
            请求失败=====> \(target)
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            """)
            break
        }
        #endif
    }
    
}
