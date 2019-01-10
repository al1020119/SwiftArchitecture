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
//  SQLModelUtils
//
//  Created by iCocos on 2019/01/03.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SQLModelUtils.swift
// @abstract 数据库模型服务
// @discussion 数据库模型存储于配置
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

let SingleModelName = "SingleModel"
let ConfigModelName = "ConfigModel"
let AccountModelName = "AccountModel"

///default db path
public func getSQLiteDBPath() -> String?{
 
    NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    
    /// 沙盒路径
    let documentDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    
    let fileManager = FileManager.default
    var isDir : ObjCBool = false
    let isExits = fileManager.fileExists(atPath: documentDirPath, isDirectory:&isDir)
    
    if isExits && !isDir.boolValue{
        fatalError("The dir is file，can not create dir.")
    }
    
    if !isExits {
        try! FileManager.default.createDirectory(atPath: documentDirPath, withIntermediateDirectories: true, attributes: nil)
        print("Create db dir success-\(documentDirPath)")
    }
    
    /// 文件路径
    let dbPath = documentDirPath + "/Single_App.db"
    if !FileManager.default.fileExists(atPath: dbPath) {
        FileManager.default.createFile(atPath: dbPath, contents: nil, attributes: nil)
        print("Create db file success-\(dbPath)")
        
    }
    
    print(dbPath)
    return dbPath
}

