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
//  SwiftImport.swift
//
//  Created by iCocos on 2019/01/07.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftImport.swift
// @abstract Codeable拓展
// @discussion 实现基本的Codeable操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import Foundation

public final class Codeable<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}


public protocol CodeableCompatible {
    associatedtype ExtendType
    var codeable: ExtendType { get }
}


public extension CodeableCompatible {
    public var codeable: Codeable<Self> {
        return Codeable(self)
    }
}


extension NSObject: CodeableCompatible {}
extension String: CodeableCompatible {}
extension Int: CodeableCompatible {}
extension Float: CodeableCompatible {}
extension Double: CodeableCompatible {}
extension Array: CodeableCompatible {}
extension Dictionary: CodeableCompatible {}
extension Set: CodeableCompatible {}
extension Data: CodeableCompatible {}
extension Date: CodeableCompatible {}
extension URL: CodeableCompatible {}
//extension Device: CodeableCompatible {}

/* example
 
 extension Codeable where Base: UIView {
 public func logFrame() {
 print(base.frame)
 }
 }
 
 let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
 v.codeable.logFrame()
 
 extension Codeable where Base == String {
 public func intValue() -> Int? {
 return Int(base)
 }
 }
 
 "123".codeable.intValue()
 */

public final class WeakReference {
    public weak var object: AnyObject?
    public init(_ object: AnyObject?) {
        self.object = object
    }
}

public extension Codeable {
    
    func getWeakObject(_ key: UnsafeRawPointer) -> AnyObject? {
        return (getStrongObject(key) as? WeakReference)?.object
    }
    
    func setWeakObject(_ key: UnsafeRawPointer, _ value: AnyObject?) -> Void {
        if let value = value {
            setStrongObject(key, WeakReference(value))
        } else {
            setStrongObject(key, nil)
        }
    }
    
    func getStrongObject(_ key: UnsafeRawPointer) -> Any! {
        return objc_getAssociatedObject(base, key)
    }
    
    func setStrongObject(_ key: UnsafeRawPointer, _ value: Any!) -> Void {
        objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func getAssignObject(_ key: UnsafeRawPointer) -> Any! {
        return objc_getAssociatedObject(base, key)
    }
    
    func setAssignObject(_ key: UnsafeRawPointer, _ value: Any!) -> Void {
        objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_ASSIGN)
    }
}
