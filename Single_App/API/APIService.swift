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
//  APIService.swift
//
//  Created by iCocos on 2018/12/21.
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

public enum APIService {
    case loadCarBrand
}

extension APIService: TargetType {
    public var baseURL: URL {
        return URL(string: isRelease ? releaseUrl : debugUrl)!
    }
    
    public var path: String {
        switch self {
        case .loadCarBrand:
            return "getXcbrand"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    /// 单元测试用
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    public var task: Task {
        return .requestParameters(parameters: parameters,
                                  encoding: parameterEncoding)
    }
    
    public var headers: [String : String]? {
        return [
            "Content-Type" : "application/x-www-form-urlencoded"
        ]
    }
    
    ///
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
