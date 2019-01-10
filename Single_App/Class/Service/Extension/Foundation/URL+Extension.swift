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
//  URL+Extension.swift
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class URL+Extension.swift
// @abstract URL拓展
// @discussion 实现URL分类拓展操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

extension URL {
    func parameters() -> Dictionary<String, Any> {
        var parametersDictionary = Dictionary<String, Any>.init();
        let queryComponents = self.query?.components(separatedBy: "&");
        for queryComponent in queryComponents! {
            let components = queryComponent.components(separatedBy: "=");
            let key = components.first
            let value = components.last;
            parametersDictionary[key!] = value;
        }
        return parametersDictionary;
    }
}

extension NSURL {
    
    func parameters() -> Dictionary<String, Any> {
        var parametersDictionary = Dictionary<String, Any>.init();
        let queryComponents = self.query?.components(separatedBy: "&");
        for queryComponent in queryComponents! {
            let components = queryComponent.components(separatedBy: "=");
            let key = components.first
            let value = components.last;
            parametersDictionary[key!] = value;
        }
        return parametersDictionary;
    }
}
