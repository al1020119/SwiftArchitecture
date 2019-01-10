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
//  String+Validation
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class String+Validation.swift
// @abstract 字符串验证
// @discussion 验证字符串类型，安全，合法
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

extension String {
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: count))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    public var isNumber: Bool {
        return NumberFormatter().number(from: self) != nil
    }
    /// ZJaDe: 是否包含 Emoji
    public var includesEmoji: Bool {
        for i in 0...count {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
    /// syk: 验证日期是否合法
    public var isValidateDate: Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.date(from: self) != nil
    }
}
// MARK: - NSPredicate
extension String {
    public func isValidate(by regex: String) -> Bool {
        // swiftlint:disable force_try
        return try! Regex(regex).test(testStr: self)
    }
    /// ZJaDe: 是否可以转换成数字
    public var isPureInt: Bool {
        let scan = Scanner(string: self)
        var val: Int = 0
        return scan.scanInt(&val)
    }
    /// ZJaDe: 是否全是小写字母
    public var isLowercase: Bool {
        let regex = "^[a-z]+$"
        return self.isValidate(by: regex)
    }
    /// ZJaDe: 是否全是大写字母
    public var isCapitalized: Bool {
        let regex = "^[A-Z]+$"
        return self.isValidate(by: regex)
    }
    /// ZJaDe: 是否是价格
    public var isPrice: Bool {
        let regex = "^\\d*\\.?\\d{0,2}$"
        return self.isValidate(by: regex)
    }
}
// MARK: - Regex
extension String {
    /// syk: 是否是手机号
    public var isMobilePhone: Bool {
        var result: Bool = false
        if self.isValidate(by: "^(1[0-9][0-9])[0-9]{8}$") {
            result = true
        }
        return result
    }
    /// syk: 是否是验证码
    public var isCode: Bool {
        var result: Bool = false
        if self.isValidate(by: "^[0-9]{6}$") {
            result = true
        }
        return result
    }
    /// syk: 判断名字是否正确
    public var isTrueName: Bool {
        return self.isValidate(by: "^[\\u4e00-\\u9fa5]{2,}$")
    }
    /// syk: 判断是否含有中文
    public var isContainChinese: Bool {
        return self.isValidate(by: "^.*[\\u4e00-\\u9fa5].*$")
    }
    /// syk: 纯英文
    public var isPureEnglish: Bool {
        let regex = "^[a-zA-Z]+$"
        return self.isValidate(by: regex)
    }
    /// syk: 纯英文或者纯数字
    public var isPureEnglishOrInt: Bool {
        let regex = "^[a-zA-Z]+$|^[0-9]+$"
        return self.isValidate(by: regex)
    }
}

// MARK: - Others
extension String {
    //判断是否为有效银行卡号
    public var isValidBankCard: Bool {
        guard self.isNumber else {
            return false
        }
        let numberLength = self.count
        guard numberLength >= 13 && numberLength <= 19 else {
            return false
        }
        guard let array = self.reversed().map({Int(String($0))}) as? [Int] else {
            return false
        }
        let result: (Int, Int) = array.lazy.enumerated().reduce((0, 0)) { (arg0, arg1) -> (Int, Int) in
            var (oddNumber, evenNumber) = arg0
            var (offSet, element) = arg1
            let i = offSet + 1
            if i % 2 == 0 {
                element *= 2
                if element >= 10 {
                    element -= 9
                }
                evenNumber += element
            } else {
                oddNumber += element
            }
            return (oddNumber, evenNumber)
        }
        return (result.0 + result.1) % 10 == 0
    }
}
extension String {
    /// syk: 判断输入是否为身份证号码
    public var isIdentificationNo: Bool {
        var result: Bool = false
        if self.isValidate(by: "^[0-9]{15}$|^[0-9]{18}$|^[0-9]{17}([0-9]|X|x)$") && calculateIdentificationNo(strIdentificationNo: self as NSString) {
            result = true
        }
        return result
    }
    private func calculateIdentificationNo(strIdentificationNo: NSString) -> Bool {
        var result: Bool = false

        if strIdentificationNo.length == 18 {
            let dateStr = strIdentificationNo.substring(with: NSRange(location: 6, length: 8))
            if !dateStr.isValidateDate {
                return result
            }
            let weightingCoefficient = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
            let validateNums = ["1", "0", "x", "9", "8", "7", "6", "5", "4", "3", "2"]

            var sum: Int = 0
            for i in 0..<weightingCoefficient.count {
                let bitNum = (strIdentificationNo.substring(with: NSRange(location: i, length: 1)) as NSString).integerValue
                let num = weightingCoefficient[i]

                let bit = bitNum*num

                sum += bit
            }

            let remainder = sum%11
            let validateBit = validateNums[remainder]
            let vBit = strIdentificationNo.substring(with: NSRange(location: strIdentificationNo.length-1, length: 1)).lowercased()

            if validateBit == vBit {
                result = true
            }
        } else if strIdentificationNo.length == 15 {
            let str = "19"+strIdentificationNo.substring(with: NSRange(location: 6, length: 6))
            if str.isValidateDate {
                result = true
            }
        }

        return result
    }
}
