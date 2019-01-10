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
//  FileManager+Extension.swift
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class FileManager+Extension.swift
// @abstract FileManager拓展
// @discussion 实现FileManager分类拓展操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

extension FileManager {
    
    /// 根据文件路径获取文件的属性
    ///
    /// - Parameter ofPath: 文件路径
    /// - Returns: 文件属性
    static func fileAttributes(ofPath: String) -> Dictionary<FileAttributeKey, Any> {
        return try! FileManager.default.attributesOfItem(atPath: ofPath);
    }
    
    /// 根据文件的路径获取文件的大小
    static func fileSize(ofPath: String) -> Float {
        return FileManager.fileAttributes(ofPath: ofPath)[FileAttributeKey.size] as! Float
    }
    
    /// 删除指定路径
    static func delete(ofPath: String) -> Bool {
        if FileManager.default.fileExists(atPath: ofPath) {
            do {
                try FileManager.default.removeItem(atPath: ofPath);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
    
    /// 创建指定路径
    static func createFolder(ofPath: String) -> Bool {
        if !FileManager.default.fileExists(atPath: ofPath) {
            do {
                try FileManager.default.createDirectory(atPath: ofPath, withIntermediateDirectories: true, attributes: nil);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
    
    /// 创建指定文件路径和内容
    static func createFile(ofPath: String, data: Data?) -> Bool {
        if !FileManager.default.fileExists(atPath: ofPath) {
            if FileManager.default.createFile(atPath: ofPath, contents: data, attributes: nil) {
                return true;
            }
            return false;
        }
        return false;
    }
    
    /// 移动文件，从path移动到aimsPath
    static func move(path: String, toAimsPath: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.moveItem(atPath: path, toPath: toAimsPath);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
    
    /// 复制文件到指定路径
    static func copy(path: String, toAimsPath: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.copyItem(atPath: path, toPath: toAimsPath);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
    
    /// 重命名文件
    static func rename(path: String, name: String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            let toAimsPath = "\((path as NSString).deletingLastPathComponent)/\(name)";
            
            do {
                try FileManager.default.moveItem(atPath: path, toPath: toAimsPath);
            } catch  {
                return false;
            }
            return true;
        }
        return false;
    }
}

extension FileManager {
    
    func isDirectory(path: String) -> Bool {
        var isDirectory: ObjCBool = ObjCBool(false)
        _ = self.fileExists(atPath: path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
    
    
    func createDirectory(atRootDirectory root:FileManager.SearchPathDirectory, folderName: String) -> String? {
        let rootPath = NSSearchPathForDirectoriesInDomains(root, .userDomainMask, true).last
        let folderPath = rootPath?.appending(folderName)
        if (self.fileExists(atPath: folderPath!) == false) {
            do {
                try self.createDirectory(atPath: folderPath!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
            
        }
        return folderPath
    }
    
    
    func fileSize(atPath path: String) -> UInt {
        var isDirectory: ObjCBool = ObjCBool(false)
        let exists = self.fileExists(atPath: path, isDirectory: &isDirectory)
        if (exists == false) {
            return 0
        }
        
        if (isDirectory.boolValue) {
            
            /// 带throws的方法代表可以捕获异常
            /*
             try!代表不捕获异常
             捕获异常则使用do catch
             do {
             try <#throwing expression#>
             } catch <#pattern#> {
             <#statements#>
             }
             */
            
            let subPaths = try! self.contentsOfDirectory(atPath: path)
            
            var totalSize: UInt = 0
            for subPath in subPaths {
                let fullPath = path.appending(subPath)
                totalSize += self.fileSize(atPath: fullPath)
            }
            return totalSize
            
        } else {
            let info = try! self.attributesOfItem(atPath: path)
            return info[FileAttributeKey.size] as! UInt
        }
    }
}
