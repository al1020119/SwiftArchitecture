//
//  SYDeviceableSource.swift
//
//  Created by WuhanSy on 2018/11/30.
//
//  Copyright © ShengYang. All rights reserved.
//

import UIKit


public extension SYDeviceable {
    
    static var device:DeviceType {
        return getDevice()
    }
    
    static var systemVersion: Double {
        return getVersion()
    }
    
    static var diagonal: DeviceDiagonal {
        return getDiagonal(deviceType: device)
    }
    
    static var isPhone: Bool {
        return getIsPhone(deviceType: device)
    }
    
    static var isPad: Bool {
        return getIsPad(deviceType: getDevice())
    }
    
    static var statusBarHeight: CGFloat {
        return getStatusBarHeight(deviceType: device)
    }
    
    static var navigationBarHeight: CGFloat {
        return getNavigationBarHeight(deviceType: device)
    }
    
    static var statusBarAndNavigationBarHeight: CGFloat {
        return getStatusBarAndNavigationBarHeight(deviceType: device)
    }
    
    static var tabbarAndSafeBottomHeight: CGFloat {
        return getTabbarAndSafeBottomHeight(deviceType: device)
    }
    
    static var safeBottomHeight: CGFloat {
        return getSafeBottomHeight()
    }
    
    static var isFullScreen: Bool {
        return getIsFullScreen(deviceType: device)
    }
}

extension SYDeviceable {
    
    static func getDevice() -> DeviceType {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return .iPhone4
        case "iPhone4,1": return .iPhone4s
        case "iPhone5,1", "iPhone5,2": return .iPhone5
        case "iPhone5,3", "iPhone5,4": return .iPhone5c
        case "iPhone6,1", "iPhone6,2": return .iPhone5s
        case "iPhone7,2": return .iPhone6
        case "iPhone7,1": return .iPhone6Plus
        case "iPhone8,1": return .iPhone6s
        case "iPhone8,2": return .iPhone6sPlus
        case "iPhone9,1", "iPhone9,3": return .iPhone7
        case "iPhone9,2", "iPhone9,4": return .iPhone7Plus
        case "iPhone8,4": return .iPhoneSE
        case "iPhone10,1", "iPhone10,4": return .iPhone8
        case "iPhone10,2", "iPhone10,5": return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6": return .iPhoneX
        case "iPhone11,2": return .iPhoneXs
        case "iPhone11,4", "iPhone11,6": return .iPhoneXsMax
        case "iPhone11,8": return .iPhoneXr
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3": return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6": return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3": return .iPadAir
        case "iPad5,3", "iPad5,4": return .iPadAir2
        case "iPad6,11", "iPad6,12": return .iPad5
        case "iPad7,5", "iPad7,6": return .iPad6
        case "iPad2,5", "iPad2,6", "iPad2,7": return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6": return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9": return .iPadMini3
        case "iPad5,1", "iPad5,2": return .iPadMini4
        case "iPad6,3", "iPad6,4": return .iPadPro9Inch
        case "iPad6,7", "iPad6,8": return .iPadPro12Inch
        case "iPad7,1", "iPad7,2": return .iPadPro12Inch2
        case "iPad7,3", "iPad7,4": return .iPadPro10Inch
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .iPadPro11Inch
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .iPadPro12Inch3
        case "AudioAccessory1,1": return .homePod
        case "i386", "x86_64": return .simulator(.unknown(identifier))
        default: return .unknown(identifier)
        }
    }
    
    static func getVersion() -> Double {
        return Double(UIDevice.current.systemVersion) ?? -1
    }
    
    static func getDiagonal(deviceType: DeviceType) -> DeviceDiagonal {
        switch deviceType {
        case .iPhone4, .iPhone4s:
            return .iPhone35
        case .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE:
            return .iPhone40
        case .iPhone6, .iPhone6s, .iPhone7, .iPhone8:
            return .iPhone47
        case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:
            return .iPhone55
        case .iPhoneX, .iPhoneXs:
            return .iPhone58
        case .iPhoneXr:
            return .iPhone61
        case .iPhoneXsMax:
            return .iPhone65
        case .iPad2, .iPad3, .iPad4, .iPad5, .iPad6, .iPadAir, .iPadAir2, .iPadPro9Inch:
            return .iPad97
        case .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4:
            return .iPad79
        case .iPadPro10Inch:
            return .iPad105
        case .iPadPro11Inch:
            return .iPad110
        case .iPadPro12Inch, .iPadPro12Inch2, .iPadPro12Inch3:
            return .iPad129
        case .homePod, .unknown(_):
            return .unknown
        case .simulator(let device):
            return getDiagonal(deviceType: device)
        }
    }
    
    static func getIsPhone(deviceType: DeviceType) -> Bool {
        switch deviceType {
        case .iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE, .iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus, .iPhoneX, .iPhoneXs, .iPhoneXr, .iPhoneXsMax:
            return true
        case .simulator(let device):
            return getIsPhone(deviceType: device)
        default:
            return false
        }
    }
    
    static func getIsPad(deviceType: DeviceType) -> Bool {
        
        switch deviceType {
        case .iPadPro12Inch3, .iPadPro12Inch2, .iPadPro12Inch, .iPadPro11Inch, .iPadPro10Inch, .iPadPro9Inch, .iPadMini4, .iPadMini3, .iPadMini2, .iPadMini, .iPadAir2, .iPadAir, .iPad6, .iPad5, .iPad4, .iPad3, .iPad2 :
            return true
        case .simulator(let device):
            return getIsPad(deviceType: device)
        default:
            return false
        }
    }
    
    static func getIsFullScreen(deviceType: DeviceType) -> Bool {
        switch deviceType {
        case .iPhoneX, .iPhoneXsMax, .iPhoneXr, .iPhoneXs:
            return true
        case .simulator(let device):
            return getIsFullScreen(deviceType: device)
        default:
            return false
        }
    }
    
    static func getStatusBarHeight(deviceType: DeviceType) -> CGFloat {
        switch deviceType {
        case .iPhoneX, .iPhoneXs, .iPhoneXr, .iPhoneXsMax:
            return 44.0
        case .iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE, .iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus:
            return 20.0
        case .simulator(let device):
            return getStatusBarHeight(deviceType: device)
        default:
            return 20.0
        }
    }
    
    static func getNavigationBarHeight(deviceType: DeviceType) -> CGFloat {
        
        switch deviceType {
        case .iPhoneX, .iPhoneXs, .iPhoneXr, .iPhoneXsMax:
            return 44.0
        case .iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE, .iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus:
            return 40.0
        case .simulator(let device):
            return getNavigationBarHeight(deviceType: device)
        default:
            return 40.0
        }
    }
    
    static func getStatusBarAndNavigationBarHeight(deviceType: DeviceType) -> CGFloat {
        switch deviceType {
        case .iPhoneX, .iPhoneXs, .iPhoneXr, .iPhoneXsMax:
            return 88.0
        case .iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE, .iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus:
            return 64.0
        case .simulator(let device):
            return getStatusBarAndNavigationBarHeight(deviceType: device)
        default:
            return 64.0
            
        }
    }
    
    static func getTabbarAndSafeBottomHeight(deviceType: DeviceType) -> CGFloat {
        switch deviceType {
        case .iPhoneX, .iPhoneXs, .iPhoneXr, .iPhoneXsMax:
            return 83.0
        case .iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE, .iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus:
            return 49.0
        case .simulator(let device):
            return getTabbarAndSafeBottomHeight(deviceType: device)
        default:
            return 49.0
            
        }
    }
    
    static func getSafeBottomHeight() -> CGFloat {
        return getTabbarAndSafeBottomHeight(deviceType: getDevice()) - 49.0
    }
}

