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
//  AppTools
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class AppTools.swift
// @abstract App工具
// @discussion App基础工具服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

public struct AppTools<Base> {
    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

public protocol AppToolsCompatible {
    associatedtype RATCompatibleType
    var rat: RATCompatibleType { get }
    static var rat: RATCompatibleType.Type { get }
}

public extension AppToolsCompatible {
    public var rat: AppTools<Self> {
        return AppTools(self)
    }

    public static var rat: AppTools<Self>.Type {
        return AppTools.self
    }
}

extension NSObject: AppToolsCompatible { }
