//
//  BadgeViewController.swift
//  BadgeDemo
//
//  Created by ac on 2017/3/26.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class BadgeViewController: UIViewController {

  @IBOutlet weak var autoLayoutView1: UIView!
  @IBOutlet weak var autoLayoutView2: UIView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //imgView.single_showBadge(with: .redDot)
    
    Badge.default.redDotWidth = 20
    
    let redDotView = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 30))
    redDotView.backgroundColor = UIColor.blue
    redDotView.single_showBadge(with: .redDot)
    redDotView.single_badgeText = 123123123
    view.addSubview(redDotView)
    
    let numView = UIView(frame: CGRect(x: 100, y: 200, width: 50, height: 30))
    numView.backgroundColor = UIColor.yellow
    numView.single_badgeFont = UIFont.systemFont(ofSize: 14)
    numView.single_showBadge(with: .number(with: 999))
    view.addSubview(numView)
    
    autoLayoutView1.single_badgeRedDotWidth = 20
    autoLayoutView1.single_badgeBackgroundColor = UIColor.yellow
    autoLayoutView1.single_badgeCenterOffset = CGPoint(x: 10, y: 10)
    autoLayoutView1.single_showBadge(with: .redDot)
    
    autoLayoutView2.single_badgeFont = UIFont.systemFont(ofSize: 14)
    autoLayoutView2.single_badgeMaximumNumber = 19
    autoLayoutView2.single_badgeTextColor = UIColor.black
    autoLayoutView2.single_showBadge(with: .number(with: 20))
    
    
    let firstItem = tabBarController?.tabBar.items?.first
    firstItem?.single_badgeRedDotWidth = 10
    firstItem?.single_showBadge(with: .redDot)
    let lastItem = tabBarController?.tabBar.items?.last
    lastItem?.single_showBadge(with: .number(with: 20))
    
//    let leftItem = UIBarButtonItem(image: #imageLiteral(resourceName: "user01"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
//    navigationItem.leftBarButtonItem = leftItem
//    leftItem.single_badgeRedDotWidth = 8
//    leftItem.single_badgeCenterOffset = CGPoint(x: -8, y: 0)
//    leftItem.single_showRedDot(true)
//    
//    let rightItem = UIBarButtonItem(title: "点击", style: .plain, target: self, action: #selector(leftBarButtonClicked))
//    navigationItem.rightBarButtonItem = rightItem
//    rightItem.single_badgeRedDotWidth = 8
//    rightItem.single_showRedDot(true)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    autoLayoutView1.single_badgeTextColor = UIColor.blue
    autoLayoutView1.single_showBadge(with: .number(with: 10))
    
    autoLayoutView2.single_badgeRedDotWidth = 8
    autoLayoutView2.single_showRedDot(true)
  }
  
  @objc private func leftBarButtonClicked() {
    
  }

}

