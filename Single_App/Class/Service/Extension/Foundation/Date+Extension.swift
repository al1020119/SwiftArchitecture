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
//  Date+Extension.swift
//
//  Created by iCocos on 2018/12/23.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class Date+Extension.swift
// @abstract Date拓展
// @discussion 实现Date分类拓展操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

private let kDATE_MINUTE_SEC = 60;      // 一分 = 60秒
private let kDATE_HOURS_SEC  = 3600;    // 一小时 = 60分 = 3600秒
private let kDATE_DAY_SEC    = 86400;   // 一天 = 24小时 = 86400秒
private let kDATE_WEEK_SEC   = 604800;  // 一周 = 7天 =  604800秒

import Foundation

extension Date {
    func string(with format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension Date {
    var year: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.year, from: self);
        }
    }
    
    var month: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.month, from: self);
        }
    }
    
    var day: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.day, from: self);
        }
    }
    
    var hour: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.hour, from: self);
        }
    }
    
    var minute: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.minute, from: self);
        }
    }
    
    var second: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.second, from: self);
        }
    }
    
    var nanosecond: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.nanosecond, from: self);
        }
    }
    
    var weekday: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.weekday, from: self);
        }
    }
    
    var weekdayOrdinal: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.weekdayOrdinal, from: self);
        }
    }
    
    var weekOfMonth: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.weekOfMonth, from: self);
        }
    }
    
    var weekOfYear: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.weekOfYear, from: self);
        }
    }
    
    var yearForWeekOfYear: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.yearForWeekOfYear, from: self);
        }
    }
    
    var quarter: Int {
        get {
            return NSCalendar.current.component(Calendar.Component.quarter, from: self);
        }
    }
    
    /// 闰月
    var isLeapMonth: Bool {
        get {
            return DateComponents.init().isLeapMonth!;
        }
    }
    
    /// 闰年
    var isLeapYear: Bool {
        get {
            let year = self.year;
            return ((year % 400 == 0) || (year % 100 == 0) || (year % 4 == 0));
        }
    }
    
    /// 今天
    var isToday: Bool {
        get {
            if (fabs(self.timeIntervalSinceNow) >= Double(kDATE_DAY_SEC)) {
                return false;
            }
            return Date.init().day == self.day;
        }
    }
}

extension Date {
    
    static func dateWithString(_ stringDate: String) -> Date? {
        return Date.dateWithString(stringDate, "yyyy-MM-dd HH:mm:ss");
    }
    
    static func dateWithString(_ stringDate: String, _ format: String) -> Date? {
        let formatter = DateFormatter.init();
        formatter.locale = NSLocale.current;
        formatter.dateFormat = format;
        return formatter.date(from: stringDate);
    }
    
    func string() -> String {
        return self.stringWithFormat(format: "yyyy-MM-dd HH:mm:ss");
    }
    
    func stringWithFormat(format: String) -> String {
        let formatter = DateFormatter.init();
        formatter.locale = NSLocale.current;
        formatter.dateFormat = format;
        return formatter.string(from: self as Date);
    }
    
    /// 明天
    static func dateTomorrow() -> Date {
        return Date.dateWithDaysFromNow(days: 1);
    }
    
    /// 后几天
    static func dateWithDaysFromNow(days: NSInteger) -> Date {
        return Date.init().dateByAdding(days: days);
    }
    
    /// 昨天
    static func dateYesterday() -> Date {
        return Date.dateWithDaysBeforeNow(days: 1);
    }
    
    /// 前几天
    static func dateWithDaysBeforeNow(days: NSInteger) -> Date {
        return Date.init().dateByAdding(days: -(days));
    }
    
    /// 当前小时后hours个小时
    static func dateWithHoursFromNow(hours: NSInteger) -> Date {
        return Date.dateByAddingTimeInterval(ti: TimeInterval(kDATE_HOURS_SEC * hours));
    }
    
    /// 当前小时前hours个小时
    static func dateWithHoursBeforeNow(hours: NSInteger) -> Date {
        return Date.dateByAddingTimeInterval(ti: TimeInterval(-kDATE_HOURS_SEC * hours));
    }
    
    /// 当前分钟后minutes个分钟
    static func dateWithMinutesFromNow(minutes: NSInteger) -> Date {
        return Date.dateByAddingTimeInterval(ti: TimeInterval(kDATE_MINUTE_SEC * minutes));
    }
    
    /// 当前分钟前minutes个分钟
    static func dateWithMinutesBeforeNow(minutes: NSInteger) -> Date {
        return Date.dateByAddingTimeInterval(ti: TimeInterval(-kDATE_MINUTE_SEC * minutes));
    }
    
    /// 追加天数，生成新的Date
    func dateByAdding(days: NSInteger) -> Date {
        var dateComponents = DateComponents.init();
        dateComponents.day = days;
        let date = NSCalendar.current.date(byAdding: dateComponents, to: (self as Date?)!);
        return (date as Date?)!;
    }
    
    /// 追加秒数，生成新的Date
    static func dateByAddingTimeInterval(ti: TimeInterval) -> Date {
        let aTimeInterval = Date.init().timeIntervalSinceReferenceDate + ti;
        let date = Date.init(timeIntervalSinceReferenceDate: aTimeInterval);
        return date;
    }

}
