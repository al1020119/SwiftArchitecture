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
//  SwiftTools.swift
//
//  Created by iCocos on 2018/12/27.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class SwiftTools.swift
// @abstract Swifth工具
// @discussion 实现基本的Swifth工具操作与服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation
import UIKit
import CryptoSwift      // md5加密

/// 通用工具
public class Tool {
    
    /**
     封装的UILabel 初始化
     
     - parameter frame:      大小位置
     - parameter textString: 文字
     - parameter font:       字体
     - parameter textColor:  字体颜色
     
     - returns: UILabel
     */
    public class func initALabel(frame:CGRect,textString:String,font:UIFont,textColor:UIColor) -> UILabel {
        let aLabel = UILabel()
        aLabel.frame = frame
        aLabel.backgroundColor = UIColor.clear
        aLabel.text = textString
        aLabel.font = font
        aLabel.textColor = textColor
        //aLabel.sizeToFit()
        
        return aLabel
    }
    
    /**
     封装的UIButton 初始化
     
     - parameter frame:       位置大小
     - parameter titleString: 按钮标题
     - parameter font:        字体
     - parameter textColor:   标题颜色
     - parameter bgImage:     按钮背景图片
     
     - returns: UIButton
     */
    public class func initAButton(frame:CGRect ,titleString:String, font:UIFont, textColor:UIColor, bgImage:UIImage?) -> UIButton {
        let aButton = UIButton()
        aButton.frame = frame
        aButton.backgroundColor = UIColor.clear
        aButton .setTitle(titleString, for: UIControl.State.normal)
        aButton .setTitleColor(textColor, for: UIControl.State.normal)
        aButton.titleLabel?.font = font
        if bgImage != nil { // bgImage 必须是可选类型，否则警告
            aButton .setBackgroundImage(bgImage, for: UIControl.State.normal)
        }
        
        return aButton
    }
    
    /// 保存NSArray 数据到本地文件
    public class func saveDataToFile(resultArray: NSArray! , fileName: String!) {
        let jsonString : NSString = self.toJSONString(arr: resultArray)!
        let jsonData :Data? = jsonString.data(using: UInt(String.Encoding.utf8.hashValue))
        
        let file = fileName
        let fileUrl = URL(fileURLWithPath: kPathTemp).appendingPathComponent(file!)
        print("fileUrl = \(fileUrl)")
        let data = NSMutableData()
        data.setData(jsonData!)
        if data.write(toFile: fileUrl.path, atomically: true) {
            print("保存成功：\(fileUrl.path)")
        } else {
            print("保存失败：\(fileUrl.path)")
        }
    }
    
    /// 从本地获取json数据
    public class func getJsonFromFile(fileName: String) -> Any? {
        let file = fileName
        let fileUrl = URL(fileURLWithPath: kPathTemp).appendingPathComponent(file)
        if let readData = NSData.init(contentsOfFile: fileUrl.path) {
            let jsonValue = try? JSONSerialization.jsonObject(with: readData as Data, options: .allowFragments)
            print("获取成功：\(fileUrl.path)")
            return jsonValue
        } else {
            print("获取失败：\(fileUrl.path)")
            return nil
        }
    }
    
    /// 转换数组到JSONStirng
    public class func toJSONString(arr: NSArray!) -> NSString? {
        guard let data = try? JSONSerialization.data(withJSONObject: arr, options: .prettyPrinted),
            // Notice the extra question mark here!
            let strJson = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
                //throws MyError.InvalidJSON
                return nil
        }
        return strJson
    }
    
    /// 加密算法
    public class func md5Action(origin: String!, _ salt: String?) -> String! {
        var str : String! = origin
        if let salt = salt {
            str = origin + salt
        }
        let resultString = str.md5()
        return resultString
    }

}
