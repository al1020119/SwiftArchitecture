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
//  NetworkingHandler.swift
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class NetworkingHandler.swift
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import RxSwift
import Moya
import HandyJSON
import Alamofire

public class NetworkingHandler: RequestCacheProtocol {
    
    // 数据缓存有效时间 默认5分钟
    public static var requestCacheValidTime: Int = 5 * 60
    
    static let APIProvider = MoyaProvider<APIService>(plugins: [SingleShowState(),
                                                                  SLPrintParameterAndJson()])
    
    /// 网络请求
    ///
    /// - Parameter APIService: APIService枚举
    /// - Returns:
    public static func request(_ APIService: APIService) -> Observable<NR> {

        return Observable<NR>.create { (observer) -> Disposable in

            if APIService.cacheData {
                // 从缓存获取数据
                loadDataFromCacheWithTarget(APIService, success: { (response) in
                    
                    observer.onNext(response)
                    observer.onCompleted()
                    
                }, failure: { (error) in
                    observer.onNext(NR(code: HttpStatus.requestFailed.rawValue,
                                       message: nil,
                                       data: nil,
                                       error: APIError.SingleRequestFailed(error: error)))
                    observer.onCompleted()
                })
                return Disposables.create()
            }
            else {
                // 从网络获取数据
                loadDataFromNetworkWithTarget(APIService, success: { (response) in
                    observer.onNext(response)
                    observer.onCompleted()
                }, failure: { (error) in
                    observer.onNext(NR(code: HttpStatus.requestFailed.rawValue,
                                       message: nil,
                                       data: nil,
                                       error: APIError.SingleRequestFailed(error: error)))
                    observer.onCompleted()
                })
            }
            
            return Disposables.create()
        }
//            .debug()
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .filterFailure(nil)
    }
}

/// 网络检测
public class SLNetworkStatusManager {
    
    public var networkStatus: NetworkReachabilityManager.NetworkReachabilityStatus = .unknown
    private var manager: NetworkReachabilityManager?
    
    public static let shared: SLNetworkStatusManager = {
        let shared = SLNetworkStatusManager()
        shared.manager = NetworkReachabilityManager(host: "www.baidu.com")
        return shared
    }()
    private init() {}
    
    /// 开始监测
    public func start() {
        manager?.listener = { [weak self] status in
            self?.networkStatus = status
        }
        manager?.startListening()
    }
    
    func checkNetworkStatus() {
        switch networkStatus {
        case .notReachable:
            print("当前网络=====> 无网络连接")
        case .unknown:
            print("当前网络=====> 未知网络")
        case .reachable(.ethernetOrWiFi):
            print("当前网络=====> 以太网或WIFI")
        case .reachable(.wwan):
            print("当前网络=====> 蜂窝移动网络")
        }
    }
}
