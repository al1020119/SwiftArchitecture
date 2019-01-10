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
//  SwiftImport.swift
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class SwiftImport.swift
// @abstract 全局导入
// @discussion Swift全局导入，类型OC时代的pch
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import Foundation
import UIKit
import QuartzCore

//░░░░░░░░░░░░░░░░ @_exported用于在自己模块中导出其他模块 ░░░░░░░░░░░░░░░░░//

// ******************************Origin********************************
@_exported import CoreLocation
@_exported import CoreData

@_exported import ObjectiveC
//
//// ****************************RX**********************************
//@_exported import Moya
////@_exported import Result
//@_exported import RxSwift
//@_exported import SnapKit
//@_exported import RxCocoa
//@_exported import RxSwiftExt
//@_exported import RxDataSources
//@_exported import Differentiator
//
//@_exported import Action
//@_exported import Then
//
//// ****************************Net&Img**********************************
//@_exported import Kingfisher
//@_exported import Alamofire
//@_exported import SwiftyJSON
//@_exported import HandyJSON
//
//// ****************************Data**********************************
//@_exported import SQLite
//@_exported import YYCache
//@_exported import CryptoSwift
//@_exported import SwiftyUserDefaults
//@_exported import SwiftyAttributes
//
//// ****************************Special**********************************
//@_exported import SpriteKit
//@_exported import GameplayKit
//@_exported import Spine
//
//// ****************************View-Animation**********************************
//@_exported import Hero
//@_exported import SwiftTheme
//@_exported import Spring
//@_exported import Lottie
//@_exported import Toast_Swift
//
//// ****************************Third**********************************
//@_exported import Bugly
//@_exported import MobileCoreServices

//@_exported import
//EZSwiftExtensions,DeviceKit,SkeletonView,ViewAnimator

// ****************************Other**********************************

//@_exported import
//ESTabBarController_swift,IQKeyboardManagerSwift,EmptyDataSet_Swift
//Realm,FSCalendar,JXCategoryView,PKHUD,Hue,PKHUD,NotificationBannerSwift
//KeychainAccess,CocoaLumberjack,Gemini,SwipeCellKit,LTMorphingLabel
//Toolbar,Whisper,SwiftDate,PhoneNumberKit,Schedule,SwiftEntryKit,Charts

// ****************************typealias**********************************

//public typealias Observable = RxSwift.Observable
//public typealias Reactive = RxSwift.Reactive
//public typealias Binder = RxCocoa.Binder
