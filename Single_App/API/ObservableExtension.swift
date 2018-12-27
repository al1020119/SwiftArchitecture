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
//  ObservableExtension.swift
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class ObservableExtension.swift
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import RxSwift
import SwiftyJSON
import HandyJSON
import RxDataSources
import Moya

public typealias NR = NetworkResponse

extension Observable where E == NR {
    
    public typealias Complete = ((NR) -> Void)?
    
    
    /// JSON转Model
    ///
    /// - Parameter modelType: 要转换成的model
    /// - Returns:
    public func mapModel<T: HandyJSON>(_ modelType: T.Type) -> Observable<T> {
        return map { response in
            if response.code == HttpStatus.success.rawValue {
                /// 成功
                if response.data is [String: Any] {
                    /// 如果是字典
                    guard let model = T.deserialize(from: response.data as? [String: Any])
                        else {
                            throw APIError.SingleFailedNormal(error: "数据解析失败")
                    }
                    return model
                    
                }
                else {
                    throw APIError.SingleFailedNormal(error: "无数据")
                }
                
            }
            else if response.code == HttpStatus.logout.rawValue {
                /// 登出
                throw APIError.SingleLogout
            }
            else {
                /// 直接输出错误
                throw APIError.SingleOperationFailure(resultCode: response.code,
                                                 resultMsg: response.message)
            }
            
        }.showError()
    }
    
    
    /// JSON转Model数组
    ///
    /// - Parameter modelType: 要转换成的model
    /// - Returns:
    public func mapModels<T: HandyJSON>(_ modelType: T.Type) -> Observable<[T]> {
        return map { response in
            if response.code == HttpStatus.success.rawValue {
                /// 成功
                if response.data is [[String: Any]] {
                    /// 如果是数组
                    guard let models = [T].deserialize(from: response.data as? [[String: Any]]) as? [T]
                        else {
                            throw APIError.SingleFailedNormal(error: "数据解析失败")
                    }
                    return models
                }
                else {
                    throw APIError.SingleFailedNormal(error: "无数据")
                }
                
            }
            else if response.code == HttpStatus.logout.rawValue {
                /// 登出
                throw APIError.SingleLogout
            }
            else {
                /// 直接输出错误
                throw APIError.SingleOperationFailure(resultCode: response.code,
                                                 resultMsg: response.message)
            }
        }.showError()
    }
    
    
    // MARK: - ========以下暂时不用==========
    
    /// JSON转Model或Model数组
    ///
    /// - Parameters:
    ///   - modelType: 要转换成的model
    ///   - completeModels: model数组
    ///   - completeModel: model
    /// - Returns:
    public func JSON2Model<T: HandyJSON>(_ modelType: T.Type, completeModels: (([T]) -> Void)? = nil, completeModel: ((T) -> Void)? = nil) -> Observable<NR> {
        
        return map { response in
            if response.code == HttpStatus.success.rawValue {
                /// 成功
                if response.data is [String: Any] {
                    /// 如果是字典
                    guard let model = T.deserialize(from: response.data as? [String: Any])
                        else {
                            throw APIError.SingleFailedNormal(error: "数据解析失败")
                    }
                    completeModel?(model)
                    return response
                    
                }
                else if response.data is [[String: Any]] {
                    /// 如果是数组
                    guard let models = [T].deserialize(from: response.data as? [[String: Any]]) as? [T]
                        else {
                            throw APIError.SingleFailedNormal(error: "数据解析失败")
                    }
                    completeModels?(models)
                    return response
                    
                }
                else {
                    throw APIError.SingleFailedNormal(error: "无数据")
                }
                
            }
            else if response.code == HttpStatus.logout.rawValue {
                /// 登出
                throw APIError.SingleLogout
            }
            else {
                /// 直接输出错误
                throw APIError.SingleOperationFailure(resultCode: response.code,
                                                 resultMsg: response.message)
            }
            }.showError()
    }
    
    
    /// 成功
    ///
    /// - Parameter complete: 成功的闭包
    /// - Returns: 
    public func isSuccess(_ complete: Complete) -> Observable<NR> {
        return map { response in
            if response.code == HttpStatus.success.rawValue {
                complete?(response)
                return response
            }
            else if response.code == HttpStatus.logout.rawValue {
                /// 登出
                throw APIError.SingleLogout
            }
            else {
                /// 直接输出错误
                throw APIError.SingleOperationFailure(resultCode: response.code,
                                                 resultMsg: response.message)
            }
        }.showError()
    }
    
    
    /// 过滤失败
    ///
    /// - Parameter complete: 失败的闭包
    /// - Returns:
    public func filterFailure(_ complete: Complete) -> Observable<NR> {
        return map { response in
            if response.code == HttpStatus.success.rawValue {
                return response
            }
            else if response.code == HttpStatus.logout.rawValue {
                /// 登出
                let res = NR(code: response.code,
                             message: response.message,
                             data: response.data,
                             error: APIError.SingleLogout)
                complete?(res)
                throw res.error!
            }
            else {
                /// 直接输出错误
                let res = NR(code: response.code,
                             message: response.message,
                             data: response.data,
                             error: response.error != nil
                                ? response.error
                                : APIError.SingleOperationFailure(resultCode: response.code,
                                                             resultMsg: response.message))
                complete?(res)
                throw res.error!
            }
            }.showError()
    }
}

extension Observable {
    
    /// 输出error
    private func showError() -> Observable<E> {
        return self.do(onError: { (error) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
                print("\(error.localizedDescription)")
            }
        })
    }
}

extension Observable where E: HandyJSON {
    
    /// 转dataSource
    ///
    /// - Parameter text: 一般为空或section的header
    /// - Returns:
    public func mapSectionModel(_ text: String) -> Observable<[SectionModel<String, E>]> {
        return map { model in
            return [SectionModel(model: text, items: [model])]
        }
    }
}

extension Observable {
    
    /// 转dataSource
    ///
    /// - Parameters:
    ///   - text: String或[String],决定返回的是一个section还是多个section
    ///   - type: 由于是E是数组, 所以需要传入model的类型
    /// - Returns:
    public func mapSectionModel<T: HandyJSON>(_ text: Any, type: T.Type) -> Observable<[SectionModel<String, T>]> {
        return map { models in
            guard let models = models as? [T] else {
                return [SectionModel(model: "", items: [])]
            }
            
            if let text = text as? String {
                return [SectionModel(model: text, items: models)]
            }
            
            if let text = text as? [String] {
                
                var array = [SectionModel<String, T>]()
                
                for (index, value) in models.enumerated() {
                    var str = ""
                    if text.count - 1 < index {
                        str = text.last ?? ""
                    }else{
                        str = text[index]
                    }
                    array.append(SectionModel(model: str, items: [value]))
                }
                return array
            }
            
            return [SectionModel(model: "", items: [])]
//            return singleSection
//                ? [SectionModel(model: text, items: models)]
//                : models.compactMap { SectionModel(model: text, items: [$0]) }
            
        }
    }
}

extension Observable {
    public func bindToSelector(sel: Selector) -> Observable {
        return map{ element in
            return element
        }
    }
}


