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
//  APIService
//
//  Created by iCocos on 2018/12/25.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class APIService.swift
// @abstract Api服务
// @discussion Api请求类型与基础服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import Moya

/// API服务类枚举
///
/// - loadCarBrand: 卡片数据
public enum APIService {
    case loadCarBrand
}

// MARK: - API服务
extension APIService: TargetType {
    
    /// 基础URL
    public var baseURL: URL {
        return URL(string: isRelease ? releaseUrl : debugUrl)!
    }
    
    /// 路径
    public var path: String {
        switch self {
        case .loadCarBrand:
            return "getXcbrand"
        }
    }
    
    /// 方法
    public var method: Moya.Method {
        return .post
    }
    
    /// 单元测试用
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    /// 请求任务
    public var task: Task {
        return .requestParameters(parameters: parameters,
                                  encoding: parameterEncoding)
    }
    
    /// 头信息
    public var headers: [String : String]? {
        return [
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
    }
    
    /// 参数编码
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// 参数
    public var parameters: [String: Any] {
        return [:]
    }
    
    /// 网络请求时是否显示loading...
    public var showStats: Bool {
        return true
    }
    
    /// 是否缓存结果数据
    public var cacheData: Bool {
        return true
    }
    
}
