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
//  Created by iCocos on 2019/01/04.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftImport.swift
// @abstract Bungle拓展
// @discussion 实现基本的Bungle操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import Foundation

extension Codeable where Base: Bundle {
    func filePath(classObject:AnyClass,bundleName:String,fileName:String, fileType:String) -> String {
        
        let name:String = String(format: "File/%@", fileName)
        let bundle:Bundle = Bundle.init(for: classObject)
        let url:URL = bundle.url(forResource: bundleName, withExtension: "bundle")!
        let resourceBundle:Bundle = Bundle.init(url: url)!
        let path:String = resourceBundle.path(forResource: name, ofType: fileType)!
        
        return path
    }
}
