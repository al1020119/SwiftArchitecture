//
//  Badge.swift
//  BadgeDemo
//
//  Created by ancheng on 2017/3/27.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

@objc
public class Badge: NSObject {
  
  private override init() {
    super.init()
  }
  
  public enum BadgeType {
    case redDot
    case number(with: Int)
  }
  
  public static let `default` = Badge()
  
  // 设置全局默认属性
  public var backgroundColor = UIColor.red
  public var textColor = UIColor.white
  public var redDotWidth: CGFloat = 8
  public var font: UIFont = UIFont.boldSystemFont(ofSize: 9)
  public var maximumNumber = 0
}
