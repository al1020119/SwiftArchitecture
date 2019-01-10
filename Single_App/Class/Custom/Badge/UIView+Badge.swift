//
//  UIView+Badge.swift
//  BadgeDemo
//
//  Created by ac on 2017/5/7.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

extension UIView {
  
  private static var single_badgeBackgroundColorKey: Character!
  private static var single_badgeTextColorKey: Character!
  private static var single_badgeKey: Character!
  private static var single_badgeRedDotWidthKey: Character!
  private static var single_badgeCenterOffsetKey: Character!
  private static var single_badgeFontKey: Character!
  private static var single_badgeMaximumNumberKey: Character!
  private static var single_badgeTextKey: Character!
  
  public var single_badgeBackgroundColor: UIColor {
    set {
      objc_setAssociatedObject(self, &UIView.single_badgeBackgroundColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
      if let badge = single_badge {
        badge.backgroundColor = newValue
        setNeedsLayout()
      }
    }
    get {
      return (objc_getAssociatedObject(self, &UIView.single_badgeBackgroundColorKey) as? UIColor) ?? Badge.default.backgroundColor
    }
  }
  
  public var single_badgeTextColor: UIColor {
    set {
      objc_setAssociatedObject(self, &UIView.single_badgeTextColorKey, newValue, .OBJC_ASSOCIATION_RETAIN)
      if let badge = single_badge {
        badge.textColor = newValue
        setNeedsLayout()
      }
    }
    get {
      return (objc_getAssociatedObject(self, &UIView.single_badgeTextColorKey) as? UIColor) ?? Badge.default.textColor
    }
  }
  
  public var single_badgeRedDotWidth: CGFloat {
    set {
      objc_setAssociatedObject(self, &UIView.single_badgeRedDotWidthKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
    get {
      return (objc_getAssociatedObject(self, &UIView.single_badgeRedDotWidthKey) as? CGFloat) ?? Badge.default.redDotWidth
    }
  }
  
  public var single_badge: UILabel? {
    set {
      objc_setAssociatedObject(self, &UIView.single_badgeKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
    get {
      return objc_getAssociatedObject(self, &UIView.single_badgeKey) as? UILabel
    }
  }
  
  public var single_badgeCenterOffset: CGPoint {
    set {
      objc_setAssociatedObject(self, &UIView.single_badgeCenterOffsetKey, newValue, .OBJC_ASSOCIATION_RETAIN)
      if let badge = single_badge {
        if tag != UITabBarItem.single_imgViewTag && superview != nil {
          badge.center = CGPoint(x: frame.maxX + newValue.x, y: frame.origin.y + newValue.y)
        } else {
          badge.center = CGPoint(x: frame.width + newValue.x, y: newValue.y)
        }
        setNeedsLayout()
      }
    }
    get {
      return (objc_getAssociatedObject(self, &UIView.single_badgeCenterOffsetKey) as? CGPoint) ?? CGPoint.zero
    }
  }
  
  public var single_badgeFont: UIFont {
    set {
      objc_setAssociatedObject(self, &UIView.single_badgeFontKey, newValue, .OBJC_ASSOCIATION_RETAIN)
      if let badge = single_badge {
        badge.font = newValue
        setNeedsLayout()
      }
    }
    get {
      return (objc_getAssociatedObject(self, &UIView.single_badgeFontKey) as? UIFont) ?? Badge.default.font
    }
  }
  
  // badge的最大值，如果超过最大值，显示“最大值+”，比如最大值为99，超过99，显示“99+”，默认为0（没有最大值）
  public var single_badgeMaximumNumber: Int {
    set {
      objc_setAssociatedObject(self, &UIView.single_badgeMaximumNumberKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
    get {
      return (objc_getAssociatedObject(self, &UIView.single_badgeMaximumNumberKey) as? Int) ?? Badge.default.maximumNumber
    }
  }
  
  // 仅适用于type为number的bagde
  public var single_badgeText: Int {
    set {
      objc_setAssociatedObject(self, &UIView.single_badgeTextKey, newValue, .OBJC_ASSOCIATION_RETAIN)
      if single_badge != nil && single_badge!.tag == UIView.single_numberTag {
        single_showBadge(with: .number(with: newValue))
        setNeedsLayout()
      }
    }
    get {
      return (objc_getAssociatedObject(self, &UIView.single_badgeTextKey) as? Int) ?? 0
    }
  }
}

extension UIView {
  
  fileprivate static let single_redDotTag = 1001
  fileprivate static let single_numberTag = 1002
  
  public func single_showBadge(with type: Badge.BadgeType) {
    switch type {
    case .redDot:
      single_showRedDotBadge()
    case .number(with: let num):
      single_showNumberBadge(with: num)
    }
  }
  
  public func single_clearBadge() {
    single_badge?.isHidden = true
  }
  
  // 让之前clear过的badge重新出现，badge的值为clear之前的值
  public func single_resumeBadge() {
    if let badge = single_badge, badge.isHidden {
      badge.isHidden = false
    }
  }
  
  public func single_showRedDot(_ isShow: Bool) {
    isShow ? single_showBadge(with: .redDot) : single_clearBadge()
  }
  
  private func single_showRedDotBadge() {
    single_initBadgeView(UIView.single_redDotTag)
    single_badge?.text = ""
    single_badge?.isHidden = false
  }
  
  private func single_showNumberBadge(with num: Int) {
    if num < 0 { return }
    single_initBadgeView(UIView.single_numberTag)
    single_badge?.tag = UIView.single_numberTag
    single_badge?.isHidden = (num == 0)
    single_badge?.font = single_badgeFont
    if single_badgeMaximumNumber > 0 {
      single_badge?.text = num > single_badgeMaximumNumber ? "\(single_badgeMaximumNumber)+" : "\(num)"
    } else {
      single_badge?.text = "\(num)"
    }
    let att = NSMutableAttributedString(string: single_badge?.text ?? "")
    att.addAttributes([NSAttributedString.Key.font: single_badge!.font], range: NSRange(location: 0, length: (single_badge?.text ?? "").count))
    single_badge?.frame = att.boundingRect(with: CGSize.zero, options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil)
    single_badge?.frame.size.width = CGFloat(Int(single_badge!.frame.size.width)) + 4
    single_badge?.frame.size.height = CGFloat(Int(single_badge!.frame.size.height)) + 4
    if single_badge!.frame.size.width < single_badge!.frame.size.height {
      single_badge!.frame.size.width = single_badge!.frame.size.height
    }
    layoutIfNeeded()
    if let superView = superview, tag != UITabBarItem.single_imgViewTag {
      superView.layoutIfNeeded()
      single_badge!.center = CGPoint(x: frame.maxX + single_badgeCenterOffset.x, y: frame.origin.y + single_badgeCenterOffset.y)
    } else {
      single_badge?.center = CGPoint(x: frame.width + single_badgeCenterOffset.x, y: single_badgeCenterOffset.y)
    }
    single_badge?.layer.cornerRadius = single_badge!.frame.height / 2
    
  }
  
  private func single_initBadgeView(_ type: Int) {
    if single_badge?.tag != type {
      if single_badge == nil {
        single_badge = UILabel()
      }
      single_badge?.frame = CGRect(x: frame.width, y: -single_badgeRedDotWidth, width: single_badgeRedDotWidth, height: single_badgeRedDotWidth)
      single_badge!.textAlignment = .center
      single_badge!.backgroundColor = single_badgeBackgroundColor
      single_badge!.textColor = single_badgeTextColor
      single_badge!.tag = UIView.single_redDotTag
      layoutIfNeeded()
      single_badge!.layer.cornerRadius = single_badge!.frame.width / 2
      single_badge!.layer.masksToBounds = true
      if let superView = superview, tag != UITabBarItem.single_imgViewTag {
        superView.layoutIfNeeded()
        single_badge!.center = CGPoint(x: frame.maxX + single_badgeCenterOffset.x, y: frame.origin.y + single_badgeCenterOffset.y)
        superView.addSubview(single_badge!)
        superView.bringSubviewToFront(single_badge!)
      } else {
        single_badge!.center = CGPoint(x: frame.width + single_badgeCenterOffset.x, y: single_badgeCenterOffset.y)
        addSubview(single_badge!)
        bringSubviewToFront(single_badge!)
      }
    }
  }
  
}

