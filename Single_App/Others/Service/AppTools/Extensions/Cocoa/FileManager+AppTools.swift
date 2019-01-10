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
//  FileManager+AppTools
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class FileManager+AppTools.swift
// @abstract 文件工具
// @discussion 实现基本的文件操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

extension AppTools where Base: FileManager {
    
    /// Home Directory 文件夹的路径
    public static var homeDirectoryPath: String {
        return NSHomeDirectory()
    }
    
    /// Documents 文件夹路径
    public static var documentsPath: String? {
        return DefaultFileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.path
    }
    
    /// Caches 文件夹路径
    public static var cachesPath: String? {
        return DefaultFileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?.path
    }
    
    /// Temporary 文件夹路径
    public static var temporaryPath: String {
        return NSTemporaryDirectory()
    }
    
    /// 缓存大小
    public static var cacheSize: Int {
        var size: Int = 0
        // 取出 cache 文件路径
        guard let cachePath = FileManager.rat.cachesPath else {
            print("FileManager get cache path failed.")
            return size / (1024 * 1024)
        }
        // 取出文件夹下所有文件, 构成数组
        guard let fileNames = DefaultFileManager.subpaths(atPath: cachePath) else {
            print("FileManager get cache files failed.")
            return size / (1024 * 1024)
        }
        // 快速枚举出所有文件名
        for fileName in fileNames {
            // 把文件名拼接到路径中
            let path = cachePath.appendingFormat("/\(fileName)")
            do {
                // 取出文件属性
                let fileAttributes = try DefaultFileManager.attributesOfItem(atPath: path)
                // 取出文件大小属性
                for (key, value) in fileAttributes {
                    if key == FileAttributeKey.size {
                        // 取出文件大小进行累加
                        size += Int(truncating: value as! NSNumber)
                    }
                }
            } catch let error as NSError {
                print("FileManager get cache file attributes failed with error: \n", error)
            }
        }
        return size / (1024 * 1024)
    }

    /// 描述缓存大小的字符串
    public static var cacheSizeString: String {
        return "\(FileManager.rat.cacheSize) M"
    }

    /// 清除缓存
    public static func clearCache() {
        guard let cachesPath = FileManager.rat.cachesPath else { return }
        guard let fileNames = DefaultFileManager.subpaths(atPath: cachesPath) else { return }
        for fileName in fileNames {
            let path = cachesPath.appendingFormat("/\(fileName)")
            if DefaultFileManager.fileExists(atPath: path) {
                do {
                    try DefaultFileManager.removeItem(atPath: path)
                } catch let error as NSError {
                    print("FileManager clear cache error: \n", error)
                }
            }
        }
    }
}
