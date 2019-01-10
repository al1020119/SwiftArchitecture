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
//  RouterServiceCell
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class RouterServiceCell.swift
// @abstract 路由Cell
// @discussion 显示对应的路由列表
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

class RouterServiceCell: UITableViewCell {
  
  
  @IBOutlet weak var leftLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(push))
    contentView.addGestureRecognizer(tap)
    contentView.isUserInteractionEnabled = true
  }
  
  @objc func push(){
    RouterService.open(RouterPathService.avc)
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
