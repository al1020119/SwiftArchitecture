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
//  ValidationPassword
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class ValidationPassword.swift
// @abstract 密码验证
// @discussion 实现用户密码安全验证
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

public struct PasswordType: OptionSet {
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    public static let number: PasswordType = PasswordType(rawValue: 1 << 0)
    public static let special: PasswordType = PasswordType(rawValue: 1 << 1)
    public static let capLetter: PasswordType = PasswordType(rawValue: 1 << 2)
    public static let lowLetter: PasswordType = PasswordType(rawValue: 1 << 3)
    public static let letter: PasswordType = PasswordType(rawValue: 1 << 4)
}

extension String {
    /// ZJaDe: 是否是密码 passwordType表示密码的字符类型，如果传[] 表示不限制类型
    public func isPassword(minLength: Int, maxLength: Int?, passwordType: PasswordType = []) -> Bool {
        guard self.count >= minLength && self.count <= maxLength ?? Int.max else {
            return false
        }
        if passwordType == [] {
            return true
        }
        var result: Bool = true
        if passwordType.contains(.number) != checkContainsNumber() {
            result = false
        }
        if passwordType.contains(.letter) != checkContainsLetter() {
            result = false
        }
        if passwordType.contains(.letter) == false {
            if passwordType.contains(.lowLetter) != checkContainsLowLetter() {
                result = false
            }
            if passwordType.contains(.capLetter) != checkContainsCapLetter() {
                result = false
            }
        }
        if passwordType.contains(.special) != checkContainsSpecialChar() {
            result = false
        }
        return result
    }
    public func checkContainsNumber() -> Bool {
        return self.isValidate(by: "^.*[0-9].*$")
    }
    public func checkContainsLetter() -> Bool {
        return self.isValidate(by: "^.*[a-zA-Z].*$")
    }
    public func checkContainsLowLetter() -> Bool {
        return self.isValidate(by: "^.*[a-z].*$")
    }
    public func checkContainsCapLetter() -> Bool {
        return self.isValidate(by: "^.*[A-Z].*$")
    }
    public func checkContainsSpecialChar() -> Bool {
        return self.isValidate(by: "^.*[^a-zA-Z0-9].*$")
    }
}
