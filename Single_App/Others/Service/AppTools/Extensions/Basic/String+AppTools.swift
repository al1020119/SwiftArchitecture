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
//  String+AppTools
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class String+AppTools.swift
// @abstract 字符串工具
// @discussion 实现基本的字符串操作与逻辑
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension String {
    public var rat: StringExtension {
        return StringExtension(string: self)
    }

    public static var rat: StringExtension.Type {
        return StringExtension.self
    }

    /// 获取指定位置字符
    public subscript(original: Int) -> String {
        guard original < endIndex.encodedOffset else {
            print("\(#function): original out of end index")
            return ""
        }
        guard original >= startIndex.encodedOffset else {
            print("\(#function): original out of start index")
            return ""
        }
        return String(self[index(startIndex, offsetBy: original)])
    }

    /// 获取指定范围字符串
    public subscript(subRange: Range<Int>) -> String {
        guard let startIndex = rat_validStartIndex(original: subRange.lowerBound),
            let endIndex = rat_validEndIndex(original: subRange.upperBound),
            startIndex < endIndex else {
                print("\(#function): index out of range")
                return ""
        }
        return String(self[startIndex ..< endIndex])
    }

    /**
     * 以下三个方法对 String 的索引值做如下的检验
     * 1.索引值是否在合理的范围内, 如果不合理, 就拉回到最近的边界上
     * 2.索引值作为一个起始点 / 终止点是否合理, 如果不合理, 就返回 nil
     */
    /// 检验索引值是否在合理的范围内, 不合理则拉回到最近的边界上
    ///
    /// - Parameter original: 待检验的索引值
    /// - Returns: 经过检验的有效索引值
    private func rat_validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.encodedOffset : return startIndex
        case endIndex.encodedOffset...   : return endIndex
        default                          : return index(startIndex, offsetBy: original)
        }
    }

    /// 检验索引值是否可以作为起始点, 否则返回 nil
    ///
    /// - Parameter original: 待检验的索引值
    /// - Returns: 经过检验的有效索引值或 nil
    fileprivate func rat_validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.encodedOffset else { return nil }
        return rat_validIndex(original: original)
    }

    /// 检验索引值是否可以作为终止点, 否则返回 nil
    ///
    /// - Parameter original: 待检验的索引值
    /// - Returns: 经过检验的有效索引值或 nil
    fileprivate func rat_validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.encodedOffset else { return nil }
        return rat_validIndex(original: original)
    }

    /// 在字符串指定位置插入一个字符
    ///
    /// - Parameters:
    ///   - newElement: 插入的字符
    ///   - i: 指定位置索引
    public mutating func rat_insert(_ newElement: Character, at i: Int) {
        guard (i <= self.count) && (i >= 0) else {
            print("\(#function): index out of range")
            return
        }
        insert(newElement, at: index(startIndex, offsetBy: i))
    }

    /// 替换字符串指定范围内容
    ///
    /// - Parameters:
    ///   - subrange: 指定范围
    ///   - newValues: 用于替换的字符串
    public mutating func rat_replace(subrange: Range<Int>, with newValues: String) {
        guard (subrange.upperBound <= self.count) && (subrange.lowerBound >= 0) else {
            print("\(#function): index out of range")
            return
        }
        let start = index(startIndex, offsetBy: subrange.lowerBound)
        let end = index(startIndex, offsetBy: subrange.upperBound)
        replaceSubrange(start ..< end, with: newValues)
    }

    /// 移除字符串指定位置的字符, 并返回被移除的字符
    ///
    /// - Parameter i: 指定位置索引
    /// - Returns: 被移除的字符
    public mutating func rat_remove(at i: Int) -> Character? {
        guard (i < self.count) && (i >= 0) else {
            print("\(#function): index out of range")
            return nil
        }
        return remove(at: index(startIndex, offsetBy: i))
    }

    /// 移除字符串指定范围的内容
    ///
    /// - Parameter subrange: 指定的范围
    public mutating func rat_remove(subrange: Range<Int>) {
        guard (subrange.upperBound <= self.count) && (subrange.lowerBound >= 0) else {
            print("\(#function): index out of range")
            return
        }
        let start = index(startIndex, offsetBy: subrange.lowerBound)
        let end = index(startIndex, offsetBy: subrange.upperBound)
        removeSubrange(start ..< end)
    }
}

public struct StringExtension {
    private var string: String

    fileprivate init(string: String) {
        self.string = string
    }

    // MARK: Clear nil
    /// 清除 nil 和 NSNull 对象，并返回字符串
    ///
    /// - Parameter obj: 未经处理的对象
    /// - Returns: 经处理后的字符串
    public static func withoutNil(_ obj: Any?) -> String {
        guard let obj = obj else {
            return ""
        }

        if obj is NSNull {
            return ""
        } else if obj is NSNumber {
            return "\(obj)"
        } else {
            return "\(obj)"
        }
    }

    //  MARK: Size
    /// 返回按照给定字体绘制时, 字符串所占有的边界大小
    ///
    /// - Parameter font: 要应用于字符串的字体
    /// - Returns: 按照给定字体绘制时, 字符串所占有的边界大小
    public func size(withFont font: UIFont) -> CGSize {
        return (string as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }

    /// 返回按照给定属性绘制时, 字符串所占有的边界大小
    ///
    /// - Parameter attrs: 要应用于字符串的文本属性的字典
    /// - Returns: 按照给定属性绘制时, 字符串所占有的边界大小
    public func size(attributes attrs: [NSAttributedString.Key: Any]? = nil) -> CGSize {
        return (string as NSString).size(withAttributes: attrs)
    }

    //  MARK: Trans
    /// String 对应的 Boolean 值
    public var boolValue: Bool {
        return (string as NSString).boolValue
    }

    /// String 对应的 Int 值
    public var intValue: Int? {
        return Int(string)
    }

    /// String 对应的 Float 值
    public var floatValue: Float? {
        return Float(string)
    }

    /// String 对应的 Double 值
    public var doubleValue: Double? {
        return Double(string)
    }

    /// String 对应的 Base64 Data
    public var base64Data: Data? {
        return Data(base64Encoded: string)
    }

    /// String 对应的 Base64 Image
    public var base64Image: UIImage? {
        guard let data = base64Data else { return nil }
        return UIImage(data: data)
    }

    /// 将字符串转换为 JSON 对象
    ///
    /// - Returns: 转换得到的 JSON 对象
    public func toObject() -> Any? {
        let str = string.replacingOccurrences(of: "\0", with: "")
        guard let data = str.data(using: String.Encoding.utf8) else {
            print("AppTools String to object Error:\n", "Fail to get data")
            return nil
        }
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let error as NSError {
            print("AppTools String to object Error:\n", error)
            return nil
        }
    }

    // MARK: Basic
    /// 字符串长度
    public var length: Int {
        return string.distance(from: string.startIndex, to: string.endIndex)
    }

    /// 截取字符串(从首个字符到指定位置, 不包含指定位置的字符)
    ///
    /// - Parameter index: 指定位置索引
    /// - Returns: 截取到的字符串
    public func substring(upTo index: Int) -> String {
        guard (index <= string.count) && (index > 0) else {
            print("\(#function): index out of range")
            return ""
        }
        return String(string.prefix(upTo: string.index(string.startIndex, offsetBy: index)))
    }

    /// 截取字符串(从首个字符到指定位置, 包含指定位置的字符)
    ///
    /// - Parameter index: 指定位置索引
    /// - Returns: 截取到的字符串
    public func substring(through index: Int) -> String {
        guard (index < string.count) && (index >= 0) else {
            print("\(#function): index out of range")
            return ""
        }
        return String(string.prefix(through: string.index(string.startIndex, offsetBy: index)))
    }

    /// 截取字符串(从制定位置到最后一个字符, 包含指定位置的字符)
    ///
    /// - Parameter index: 指定位置索引
    /// - Returns: 截取到的字符串
    public func substring(from index: Int) -> String {
        guard (index < string.count) && (index >= 0) else {
            print("\(#function): index out of range")
            return ""
        }
        return String(string.suffix(from: string.index(string.startIndex, offsetBy: index)))
    }
    
    /// 截取字符串(指定范围)
    ///
    /// - Parameter range: 指定的范围
    /// - Returns: 截取到的字符串
    public func substring(with range: Range<Int>) -> String {
        guard let startIndex = string.rat_validStartIndex(original: range.lowerBound),
            let endIndex = string.rat_validEndIndex(original: range.upperBound),
            startIndex < endIndex else {
                print("\(#function): index out of range")
                return ""
        }
        let start = string.index(string.startIndex, offsetBy: startIndex.encodedOffset)
        let validLength = endIndex.encodedOffset - startIndex.encodedOffset
        let str = String(string.suffix(from: start))
        return String(str.prefix(validLength))
    }
}
