//
//  UITabBarItem+Badge.swift
//  BadgeDemo
//
//  Created by ac on 2017/5/7.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

extension UITabBarItem {
  
  static let single_imgViewTag = 1003
  
  // ⚠️ get以下属性时，必须保证UITabBarItem是有图片的，否则会崩！
  public var single_badgeBackgroundColor: UIColor {
    set {
      single_getBadgeSuperView?.single_badgeBackgroundColor = newValue
    }
    get {
      return single_getBadgeSuperView!.single_badgeBackgroundColor
    }
  }
  
  public var single_badgeTextColor: UIColor {
    set {
      single_getBadgeSuperView?.single_badgeTextColor = newValue
    }
    get {
      return single_getBadgeSuperView!.single_badgeTextColor
      
    }
  }
  
  public var single_badgeRedDotWidth: CGFloat {
    set {
      single_getBadgeSuperView?.single_badgeRedDotWidth = newValue
    }
    get {
      return single_getBadgeSuperView!.single_badgeRedDotWidth
    }
  }
  
  public var single_badge: UILabel? {
    set {
      single_getBadgeSuperView?.single_badge = newValue
    }
    get {
      return single_getBadgeSuperView!.single_badge
    }
  }
  
  public var single_badgeCenterOffset: CGPoint {
    set {
      single_getBadgeSuperView?.single_badgeCenterOffset = newValue
    }
    get {
      return single_getBadgeSuperView!.single_badgeCenterOffset
    }
  }
  
  public var single_badgeFont: UIFont {
    set {
      single_getBadgeSuperView?.single_badgeFont = newValue
    }
    get {
      return single_getBadgeSuperView!.single_badgeFont
    }
  }
  
  // badge的最大值，如果超过最大值，显示“最大值+”，比如最大值为99，超过99，显示“99+”，默认为0（没有最大值）
  public var single_badgeMaximumNumber: Int {
    set {
      single_getBadgeSuperView?.single_badgeMaximumNumber = newValue
    }
    get {
      return single_getBadgeSuperView!.single_badgeMaximumNumber
    }
  }
  
  // 仅适用于type为number的bagde
  public var single_badgeText: Int {
    set {
      single_getBadgeSuperView?.single_badgeText = newValue
    }
    get {
      return single_getBadgeSuperView!.single_badgeText
    }
  }
  
  public func single_showBadge(with type: Badge.BadgeType) {
    single_getBadgeSuperView?.single_showBadge(with: type)
  }
  
  public func single_clearBadge() {
    single_getBadgeSuperView?.single_clearBadge()
  }
  
  public func single_resumeBadge() {
    single_getBadgeSuperView?.single_resumeBadge()
  }
  
  public func single_showRedDot(_ isShow: Bool) {
    single_getBadgeSuperView?.single_showRedDot(isShow)
  }
  
  private var single_getBadgeSuperView: UIView? {
    let bottomView = value(forKeyPath: "view")
    var actualSuperView: UIView? = nil
    if let bottomView = bottomView as? UIView {
      actualSuperView = findSubview(from: bottomView, where: NSClassFromString("UITabBarSwappableImageView")!)
    }
    actualSuperView?.tag = UITabBarItem.single_imgViewTag
    return actualSuperView
  }
  
  private func findSubview(from view: UIView, where viewClass: AnyClass) -> UIView? {
    for subView in view.subviews {
      if subView .isKind(of: viewClass) {
        return subView
      }
    }
    return nil
  }
}

