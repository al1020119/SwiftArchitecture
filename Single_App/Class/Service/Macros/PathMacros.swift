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
//  PathMacros.swift
//
//  Created by iCocos on 2019/01/07.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class PathMacros.swift
// @abstract 路径宏
// @discussion 实现基本的路径宏操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

/* 获取程序的Home目录
 let kPathDocument  =       NSHomeDirectory() + "/Documents"
 let kPathLibrary   =       NSHomeDirectory() + "/Library"
 let kPathCache     =       NSHomeDirectory() + "/Library/Caches"
 let kPathTemp      =       NSHomeDirectory() + "/tmp"
 */
let kPathHome       =       NSHomeDirectory()
// temp目录
let kPathTemp       =       NSTemporaryDirectory()
// 获取：document/library/cache 目录
let kPathDocument   =       NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentationDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
let kPathLibrary    =       NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,FileManager.SearchPathDomainMask.userDomainMask, true)
let kPathCache      =       NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,FileManager.SearchPathDomainMask.userDomainMask, true)
