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
//  UserDefaults+AppTools
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UserDefaults+AppTools.swift
// @abstract 用户配置工具
// @discussion 实现基本的用户配置服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

public final class Key<ValueType: Codable> {
    fileprivate let key: String
    public init(_ key: String) {
        self.key = key
    }
}

extension AppTools where Base: UserDefaults {
    /// 检验 UserDefaults 中是否存在某个 key
    ///
    /// - Parameter key: 待检验的 key
    /// - Returns: 检验结果
    public func has<ValueType>(_ key: Key<ValueType>) -> Bool {
        return base.value(forKey: key.key) != nil
    }

    /// 获取 key 值对应的内容
    ///
    /// - Parameter key: 标记内容的 key
    /// - Returns: key 对应的内容
    public func value<ValueType>(for key: Key<ValueType>) -> ValueType? {
        if isPrimitive(type: ValueType.self) {
            return base.value(forKey: key.key) as? ValueType
        }

        guard let data = base.data(forKey: key.key) else { return nil }

        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ValueType.self, from: data)
            return result
        } catch {
            #if DEBUG
                print(error)
            #endif
        }
        return nil
    }

    /// 将内容存入 UserDefaults, 并用 key 标记
    ///
    /// - Parameters:
    ///   - value: 将要存入的内容
    ///   - key: 用于标记的 key
    public func save<ValueType>(_ value: ValueType, for key: Key<ValueType>) {
        if isPrimitive(type: ValueType.self) {
            base.set(value, forKey: key.key)
            base.synchronize()
            return
        }

        do {
            let encoder = JSONEncoder()
            let result = try encoder.encode(value)
            base.set(result, forKey: key.key)
            base.synchronize()
        } catch {
            #if DEBUG
                print(error)
            #endif
        }
    }

    /// 清除 key 值对应内容
    ///
    /// - Parameter key: 标记内容的 key
    public func clear<ValueType>(for key: Key<ValueType>) {
        base.set(nil, forKey: key.key)
        base.synchronize()
    }

    /// 检验给定类型是否为基础类型
    ///
    /// - Parameter type: 待检验的类型
    /// - Returns: 检验结果
    private func isPrimitive<ValueType>(type: ValueType.Type) -> Bool {
        switch type {
        case is String.Type, is Bool.Type, is Int.Type, is Float.Type, is Double.Type:
            return true
        default:
            return false
        }
    }

    // MARK: deprecated methods
    /// 检验 UserDefaults 中是否存在某个 key
    ///
    /// - Parameter key: 待检验的 key
    /// - Returns: 检验结果
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.has(_:)` instead.", renamed: "has(_:)")
    public func isHave(key: String) -> Bool {
        let userDefaultsDic = base.dictionaryRepresentation() as NSDictionary
        let keys = userDefaultsDic.allKeys

        for i in 0 ..< keys.count {
            let aKey = keys[i] as? String
            if key == aKey {
                return true
            }
        }
        return false
    }

    /// 将某个 key - Object 值存入 UserDefaults 中
    ///
    /// - Parameters:
    ///   - object: 将要存入的 object
    ///   - key: 将要存入的 key
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.save` instead.", renamed: "save(_:for:)")
    public func save(_ object: Any?, forKey key: String) {
        base.set(object, forKey: key)
        base.synchronize()
    }

    /// 将某个 key - Int 值存入 UserDefaults 中
    ///
    /// - Parameters:
    ///   - value: 将要存入的 Int 值
    ///   - key: 将要存入的 key
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.save` instead.", renamed: "save(_:for:)")
    public func saveInt(_ value: Int, forKey key: String) {
        base.set(value, forKey: key)
        base.synchronize()
    }

    /// 将某个 key - Float 值存入 UserDefaults 中
    ///
    /// - Parameters:
    ///   - value: 将要存入的 Float 值
    ///   - key: 将要存入的 key
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.save` instead.", renamed: "save(_:for:)")
    public func saveFloat(_ value: Float, forKey key: String) {
        base.set(value, forKey: key)
        base.synchronize()
    }

    /// 将某个 key - Double 值存入 UserDefaults 中
    ///
    /// - Parameters:
    ///   - value: 将要存入的 Double 值
    ///   - key: 将要存入的 key
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.save` instead.", renamed: "save(_:for:)")
    public func saveDouble(_ value: Double, forKey key: String) {
        base.set(value, forKey: key)
        base.synchronize()
    }

    /// 将某个 key - Bool 值存入 UserDefaults 中
    ///
    /// - Parameters:
    ///   - value: 将要存入的 Bool 值
    ///   - key: 将要存入的 key
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.save` instead.", renamed: "save(_:for:)")
    public func saveBool(_ value: Bool, forKey key: String) {
        base.set(value, forKey: key)
        base.synchronize()
    }

    /// 将某个 key - URL 值存入 UserDefaults 中
    ///
    /// - Parameters:
    ///   - url: 将要存入的 URL 值
    ///   - key: 将要存入的 key
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.save` instead.", renamed: "save(_:for:)")
    public func saveURL(_ url: URL?, forKey key: String) {
        base.set(url, forKey: key)
        base.synchronize()
    }
}

//  MARK: Savings
extension UserDefaults {
    /**
     将某个 key - Object 值存入 UserDefaults 中

     - parameter object: 将要存入的 object
     - parameter key:    将要存入的 key
     */
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.save` instead.", renamed: "rat.save(_:for:)")
    public func rat_save(_ object: Any?, forKey key: String) {
        self.set(object, forKey: key)
        self.synchronize()
    }

    /**
     将某个 key - Bool 值存入 UserDefaults 中

     - parameter value: 将要存入的 Bool 值
     - parameter key:   将要存入的 key
     */
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.save` instead.", renamed: "rat.save(_:for:)")
    public func rat_saveBool(_ value: Bool, forKey key: String) {
        self.set(value, forKey: key)
        self.synchronize()
    }

    /**
     将某个 key - Double 值存入 UserDefaults 中

     - parameter value: 将要存入的 Double 值
     - parameter key:   将要存入的 key
     */
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.save` instead.", renamed: "rat.save(_:for:)")
    public func rat_saveDouble(_ value: Double, forKey key: String) {
        self.set(value, forKey: key)
        self.synchronize()
    }
}

//  MARK: Check key exist or not
extension UserDefaults {
    /**
     检验 UserDefaults 中是否存在某个 key

     - parameter key: 待检验的 key

     - returns: 检验结果
     */
    @available(*, deprecated, message: "Extensions directly on UserDefaults are deprecated. Use `UserDefaults.standard.rat.has(key:)` instead.", renamed: "rat.has(_:)")
    public func rat_isHaveKey(key: String) -> Bool {
        let userDefaultsDic = self.dictionaryRepresentation() as NSDictionary
        let keys = userDefaultsDic.allKeys

        for i in 0 ..< keys.count {
            let aKey = keys[i] as? String
            if key == aKey {
                return true
            }
        }
        return false
    }
}
