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
//  Date+AppTools
//
//  Created by iCocos on 2018/12/29.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class Date+AppTools.swift
// @abstract 时间工具
// @discussion 实现基本的时间操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

extension Date {
    public var rat: DateExtension {
        return DateExtension(date: self)
    }

    public static var rat: DateExtension.Type {
        return DateExtension.self
    }
}

public struct DateExtension {
    private var date: Date

    fileprivate init(date: Date) {
        self.date = date
    }

    //  MARK: Transform
    /// 某个时间对应的时间戳
    public var timestamp: TimeInterval {
        return date.timeIntervalSince1970
    }

    /// 描述某个时间对应的时间戳的字符串
    public var timestampString: String {
        return String(timestamp)
    }

    /// 当前时间对应的时间戳
    public static var timestampforNow: TimeInterval {
        return Date().timeIntervalSince1970
    }

    /// 描述实时对应的时间戳的字符串
    public static var timestampForNowString: String {
        return String(Date.rat.timestampforNow)
    }

    // MARK: Component
    /// 某时间点对应的 year 值
    public var year: Int {
        return components(unit: .year)
    }

    /// 某时间点对应的 month 值
    public var month: Int {
        return components(unit: .month)
    }

    /// 某时间点对应的 day 值
    public var day: Int {
        return components(unit: .day)
    }

    /// 某时间点对应的 hour 值
    public var hour: Int {
        return components(unit: .hour)
    }

    /// 某时间点对应的 minute 值
    public var minute: Int {
        return components(unit: .minute)
    }

    /// 某时间点对应的 second 值
    public var second: Int {
        return components(unit: .second)
    }

    /// 依据参数, 给出某时间点对应的时间组件的值
    ///
    /// - Parameter unit: 需要的时间组件
    /// - Returns: 时间组件的值
    public func components(unit: Calendar.Component) -> Int {
        let cal = Calendar.current
        return cal.component(unit, from: date)
    }
}
