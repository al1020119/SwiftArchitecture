//
//  UIDeviceExtension.swift
//  APP
//
//  Created by funny on 2018/9/6.
//  Copyright © 2018年 Funny. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {

    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    static var statusNaviBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height + 44
    }

    static var tabBarHeight: CGFloat {
        return UIDevice.isIPhoneX() ? 49 + 34 : 49
    }

    static var screenHeightWithoutNavigation: CGFloat {
        return UIDevice.height - UIDevice.statusNaviBarHeight
    }

    static var screenHeightWithoutNavigationTabBar: CGFloat {
        return UIDevice.height - UIDevice.statusNaviBarHeight - UIDevice.tabBarHeight
    }

    static var singleLineWidth: CGFloat {
        return 1 / (UIScreen.main.scale)
    }

    static var singleLineAdjustOffset: CGFloat {
        return 1 / (UIScreen.main.scale) / 2
    }

    // 判断是否是iphone X系列
    static func isIPhoneX() -> Bool {
        var isPhoneX = false
        if #available(iOS 11.0, *) {
            isPhoneX = (UIApplication.shared.delegate?.window.unsafelyUnwrapped?.safeAreaInsets.bottom)! > CGFloat(0.0)
        }
        return isPhoneX
    }

    // 获取app名字
    static func appName() -> String {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        } else {
            return "APP"
        }
    }

    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    public static var appVersionAndBuild: String? {
        if appVersion != nil && appBuild != nil {
            if appVersion == appBuild {
                return "v\(appVersion!)"
            } else {
                return "v\(appVersion!)(\(appBuild!))"
            }
        }
        return nil
    }

    static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }

    static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }

    static func detectScreenShot(_ action: @escaping () -> Void) {
        //let mainQueue = OperationQueue.main
        //_ = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: mainQueue) { _ in
        //    action()
        //}
    }

    static var isDebug: Bool {
    #if DEBUG
        return true
    #else
        return false
    #endif
    }

    static var isRelease: Bool {
    #if DEBUG
        return false
    #else
        return true
    #endif
    }

    static var isSimulator: Bool {
    #if targetEnvironment(simulator)
        return true
    #else
        return false
    #endif
    }

    static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }

    static func uuidString() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }

    static func systemName() -> String {
        return UIDevice.current.systemName
    }

    static func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }

    static func systemFloatVersion() -> Float {
        return (systemVersion() as NSString).floatValue
    }

    static func deviceName() -> String {
        return UIDevice.current.name
    }

    static func deviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }

    static func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }

    static func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }

    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":  return "iPod Touch 6"

        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"

        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"

        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":  return "Apple TV 4"

        case "i386", "x86_64":  return "Simulator"

        default:  return identifier
        }
    }
}
