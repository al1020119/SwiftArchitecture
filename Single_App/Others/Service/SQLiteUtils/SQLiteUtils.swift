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
//  SQLiteUtils
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SQLiteUtils.swift
// @abstract 数据库工具
// @discussion 数据层CRUD操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import SQLite

public  func save(db:Connection? = nil, _ block: @escaping ()throws -> Void,
                        completion: ((_ error:Error?)->Void)? = nil) -> Void  {
    
    do{
        
        
        let excuteDB = (db != nil ? db! : SQLiteConfig.getDefaultDB())
        
        try excuteDB.transaction {
            try block()
        }
        
        LogInfo("Transcation success")
        completion?(nil)
    }catch{
        LogError("Transcation failure:\(error)")
        completion?(error)
    }
    
}


public  func saveAsync(db:Connection? = nil, _ block: @escaping ()throws -> Void,
                             completion: ((_ error:Error?)->Void)? = nil) -> Void  {
    
    DispatchQueue.global().async {
        
        do{
            let excuteDB = (db != nil ? db! : SQLiteConfig.getDefaultDB())
            
            try excuteDB.transaction {
                try block()
            }
            
            LogInfo("Transcation success")
            
            DispatchQueue.main.async {
                completion?(nil)
            }
            
        }catch{
            LogError("Transcation failure:\(error)")
            
            DispatchQueue.main.async {
                completion?(error)
            }
        }
        
    }
    
}

public extension Connection {
    //userVersion Database
    public var userVersion: Int32 {
        get { return Int32(try! scalar("PRAGMA user_version") as! Int64)}
        set { try! run("PRAGMA user_version = \(newValue)") }
    }
}


//project name
func bundleName() -> String{
    var bundlePath = Bundle.main.bundlePath
    bundlePath = bundlePath.components(separatedBy: "/").last!
    bundlePath = bundlePath.components(separatedBy: "/").first!
    return bundlePath
}

//class name -> AnyClass
func getClass(name:String) ->AnyClass?{
    let type = bundleName() + "." + name
    return NSClassFromString(type)
}

//MARK: - Extension



func recusionProperties(_ obj:Any) -> Dictionary<String,Any> {
    var properties = [String:Any]()
    var mirror: Mirror? = Mirror(reflecting: obj)
    repeat {
        for case let (key?, value) in mirror!.children {
            properties[key] = value
        }
        mirror = mirror?.superclassMirror
    } while mirror != nil
    
    return properties
}

extension Setter{
    func getColumnName() -> String {
        let selfPrpperties = recusionProperties(self)
        for case let (key, v) in selfPrpperties{
            if key == "column" {
                let columnPrpperties = recusionProperties(v)
                for case let (key, v) in columnPrpperties{
                    if key == "template" {
                        return (v as! String).trimmingCharacters(in: CharacterSet(charactersIn:"\""))
                    }
                }
            }
        }
        
        return ""
        //        return (recusionProperties(self)["column"] as! Expression).template
    }
    
    func getValue() -> Any? {
        let selfPrpperties = recusionProperties(self)
        for case let (key, v) in selfPrpperties{
            if key == "value" {
                return v
            }
        }
        
        return nil
        
    }
}

//variable argument  contvert to array argument
extension Table{
    // MARK: - CREATE INDEX
    public func createIndexBrage(_ columns: [Expressible]) -> String {
        typealias Function = ((_ columns:[Expressible],_ unique: Bool , _ ifNotExists: Bool ) -> String)
        let createIndexNew = unsafeBitCast(createIndex(_:unique:ifNotExists:), to: Function.self)
        return createIndexNew(columns, false, false)
    }
    
    public func createIndexBrage(_ columns: [Expressible], unique: Bool = false, ifNotExists: Bool = false) -> String {
        typealias Function = ((_ columns:[Expressible],_ unique: Bool , _ ifNotExists: Bool ) -> String)
        let createIndexNew = unsafeBitCast(createIndex(_:unique:ifNotExists:), to: Function.self)
        return createIndexNew(columns, unique, ifNotExists)
    }
    
    // MARK: - DROP INDEX
    public func dropIndexBrage(_ columns: [Expressible]) -> String {
        typealias Function = (_ columns: [Expressible]) -> String
        let dropIndexNew = unsafeBitCast(dropIndex(), to: Function.self)
        return dropIndexNew(columns)
    }
    public func dropIndexBrage(_ columns: [Expressible], ifExists: Bool = false) -> String {
        typealias Function = (_ columns: [Expressible], _ ifExists: Bool ) -> String
        let dropIndexNew = unsafeBitCast(dropIndex(_:ifExists), to: Function.self)
        return dropIndexNew(columns, ifExists)
    }
}

