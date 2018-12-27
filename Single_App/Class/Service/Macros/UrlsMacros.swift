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
//  UrlsMacros.swift
//
//  Created by iCocos on 2018/12/21.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UrlsMacros.swift
// @abstract <#类的描述#>
// @discussion <#类的功能#>
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import Foundation

let kAPI_URL                       = "http://api.impingo.me"
let kAPI_USERID                    = "userID=1404034"
let kAPI_SESSION_ID                = "sessionID=e5c8c1b3e8153e78ab"
let kAPI_SESSION_TOKEN             = "sessionToken=cce76093c4"
let kAPI_KEY                       = "key=B57B690BD66AE7B4C7F17A5E60293B20"
let kAPI_PEERID                    = "peerID=6EDEE890B4E5"
let kAPI_PRODUCTID                 = "productID=com.joyodream.pingo"
let kAPI_VERSION                   = "version=3.7"
let kAPI_VERSION_CODE              = "versionCode=15"
let kAPI_SYSVERSION                = "sysVersion=9.2.1"
let kAPI_CHANNELID                 = "channelID=App%20Store"
let kAPI_OS                        = "os=ios"

/// 首页精选列表的地址
let kHOME_TOPIC_LIST_URL           = kAPI_URL + "/topic/listSelectionBottleTopic"
/// 首页关注列表的地址
let kHOME_FOLLOW_TOPIC_LIST_URL    = kAPI_URL + "/topic/listOnlineBottleTopic"
/// 话题首页banner列表的地址
let kDISCOVER_BANNER_LIST_URL      = kAPI_URL + "/banner/listBanner"
/// 话题首页推荐列表的地址
let kDISCOVER_SUBJECTINFO_LIST_URL = kAPI_URL + "/subject/listSubjectCategory"
/// 获取话题信息的地址
let kGET_SUBJECTINFO_URL           = kAPI_URL + "/subject/getSubject"
/// 获取话题下Topic的地址
let kGET_LISTSUBJECTTOPIC_URL      = kAPI_URL + "/subject/listSubjectTopic"
/// 访客记录的地址
let kVISITOR_RECORD_URL            = kAPI_URL + "/user/listVisitUser"// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
