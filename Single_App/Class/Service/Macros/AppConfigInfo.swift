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
//  AppConfigInfo.swift
//
//  Created by iCocos on 2019/1/4.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class AppConfigInfo
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

enum NetWorkType {
    case NetworkStatesNone // 没有网络
    case NetworkStates2G // 2G
    case NetworkStates3G // 3G
    case NetworkStates4G // 4G
    case NetworkStatesWIFI // WIFI
}

class AppConfigInfo: NSObject {
    
    
    /*
     UIStatusBarSignalStrengthItemView //信号强度
     _signalStrengthRaw
     _signalStrengthBars
     _enableRSSI
     _showRSSI
     UIStatusBarServiceItemView  运营商
     _serviceString     中国电信
     _crossfadeString   null
     _crossfadeStep     0
     _maxWidth          1.797693134862316e+308
     _serviceWidth      50
     _crossfadeWidth    0
     _contentType       0
     _loopingNecessaryForString 0
     _loopNowIfNecessary        0
     _loopNowIfNecessary        0
     _loopNowIfNecessary        0
     UIStatusBarDataNetworkItemView 网络状态码
     _dataNetworkType  5
     _wifiStrengthRaw  -62
     _wifiStrengthBars 3
     _wifiLinkWarning  0
     _enableRSSI       0
     _showRSSI         0
     UIStatusBarBatteryItemView 电池标志
     _capacity  95
     _state 1
     _batterySaverModeActive 0
     _accessoryView
     _cachedImageHasAccessoryImage  1
     _cachedCapacity 95
     _cachedAXHUDCapacity 0
     _cachedImageSet
     _cachedBatteryStyle 1
     _cachedAXHUDStyle   0
     _cachedAXHUDImage
     UIStatusBarBatteryPercentItemView //电池百分比 _percentString
     UIStatusBarIndicatorItemView 闹钟
     UIStatusBarTimeItemView 时间
     _timeString 18:02
     _useCustomFadeAnimation 0
     */
    // 获取运营商 名称
    static func statusBarInfo() -> [UIView] {
        let view = UIApplication.shared.value(forKeyPath: "statusBar") as! UIView
        let foreView = view.value(forKeyPath: "foregroundView") as! UIView
        let stsBars = foreView.subviews
        return stsBars
    }
    
    // 获取运营商 名称
    class func serviceCompany() -> String {
        let stsBars = statusBarInfo()
        for info in stsBars {
            if info.isKind(of: NSClassFromString("UIStatusBarServiceItemView")!) {
                let serverStr = info.value(forKeyPath: "serviceString") as! String
                return serverStr
            }
        }
        return ""
    }
    
    // 显示系统时间
    class func currentTimeString() -> String {
        let stsBars = statusBarInfo()
        for info in stsBars {
            if info.isKind(of: NSClassFromString("UIStatusBarTimeItemView")!) {
                let serverStr = info.value(forKeyPath: "timeString") as! String
                return serverStr
            }
        }
        return ""
    }
    
    // 检测网络状态
    class func currentNetworkType() -> NetWorkType {
        let stsBars = statusBarInfo()
        var states :NetWorkType = .NetworkStatesNone
        for info in stsBars {
            if info.isKind(of: NSClassFromString("UIStatusBarDataNetworkItemView")!) {
                let networkString = info.value(forKeyPath: "dataNetworkType") as! NSNumber
                switch (networkString) {
                case 0:
                    states = .NetworkStatesNone;
                    //无网模式
                    break;
                case 1:
                    states = .NetworkStates2G;
                    break;
                case 2:
                    states = .NetworkStates3G;
                    break;
                case 3:
                    states = .NetworkStates4G;
                    break;
                case 5:
                    states = .NetworkStatesWIFI;
                    break;
                default:
                    break;
                }
                
            }
        }
        return states
        
    }
    
    // 获取当前的电量信息
    class func currentBatteryPercent() -> String {
        let stsBars = statusBarInfo()
        for info in stsBars {
            if info.isKind(of: NSClassFromString("UIStatusBarBatteryPercentItemView")!) {
                let serverStr = info.value(forKeyPath: "percentString")
                return serverStr as! String
            }
        }
        UIDevice.current.isBatteryMonitoringEnabled = true
        let battery = UIDevice.current.batteryLevel
        let betteryValue = Int((battery * 100))
        return "\(betteryValue)"
    }
    
    class func currentDataWeekString() -> String {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        let dataString = "\(String(describing: comps.month!))月\(String(describing: comps.day!))日 星期\((comps.weekday! - 1).cn)"
        return dataString
    }
    
    //class func dataWeek() -> [Int] {
    //
    //    var timers: [Int] = [] //  返回的数组
    //
    //    let calendar: Calendar = Calendar(identifier: .gregorian)
    //    var comps: DateComponents = DateComponents()
    //    comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
    //
    //    timers.append(comps.year! % 2000)  // 年 ，后2位数
    //    timers.append(comps.month!)            // 月
    //    timers.append(comps.day!)                // 日
    //    timers.append(comps.hour!)               // 小时
    //    timers.append(comps.minute!)            // 分钟
    //    timers.append(comps.second!)            // 秒
    //    timers.append(comps.weekday! - 1)      //星期
    //
    //    return timers;
    //}
    //
    //class func dataString() -> String {
    //    let date = Date()
    //    let timeFormatter = DateFormatter()
    //    timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    //    let strNowTime = timeFormatter.string(from: date)
    //    return strNowTime;
    //}
    
}


