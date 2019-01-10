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
//  SQLiteProtocol
//
//  Created by iCocos on 2018/12/27.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class SQLiteProtocol.swift
// @abstract SQL协议
// @discussion 实现数据层操作服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import SQLite

public protocol SQLiteProtocol:class {
//    static var dbName:String?{get}
//    static var db:Connection{get}
//    //'public' modifier cannot be used in protocols
//    static var CREATE_AT_KEY:String{get}
//    static var created_at:Expression<NSNumber>{get}
//
//    static var isSaveDefaulttimestamp:Bool{get}
//    static var nameOfTable: String{get}
//    static func getTable() -> Table
    
//    init()
    //default argument not permitted in protocol method
//    static func findAllinAS(_ predicate: SQLite.Expression<Bool?>?,orders: [Expressible]?)->Array<SQLiteModel>
}

public extension SQLiteProtocol where Self:SQLiteModel{
    
    
//    public static var dbName:String?{
//        return nil
//    }
//
//    static var db:Connection{
//        get{
//            if let name = dbName {
//                return SQLiteConfig.getDB(name: name)
//            }else{
//                return DBConfigration.getDefaultDB()
//            }
//
//        }
//    }
//
//    public static var CREATE_AT_KEY:String{
//        return  "created_at"
//    }
//    public static var created_at:Expression<NSNumber>{
//        return Expression<Int64>(CREATE_AT_KEY)
//    }
//
//    public static var isSaveDefaulttimestamp:Bool {
//        return false
//    }
//
//    public static var nameOfTable: String{
//        return NSStringFromClass(self).components(separatedBy: ".").last!
//    }
//
//    public static func getTable() -> Table{
//        return Table(nameOfTable)
//    }
    
}
