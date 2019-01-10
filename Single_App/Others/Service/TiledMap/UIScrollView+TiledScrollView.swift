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
//  UIScrollView+TiledScrollView
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UIScrollView+TiledScrollView.swift
// @abstract TiledScrollView
// @discussion 实现碎片地图拖动功能
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension UIScrollView
{

    func tiled_zoomScaleByZoomingIn(_ numberOfLevels: CGFloat) -> CGFloat
    {

        let newZoom = CGFloat(
        min(
        powf(2, Float(log2(self.zoomScale) + numberOfLevels)),
        Float(self.maximumZoomScale)
        )
        )
        return newZoom
    }

    func tiled_zoomScaleByZoomingOut(_ numberOfLevels: CGFloat) -> CGFloat
    {

        let newZoom = CGFloat(
        max(
        powf(2, Float(log2(self.zoomScale) - numberOfLevels)),
        Float(self.minimumZoomScale)
        )
        )
        return newZoom
    }

    func tiled_setContentCenter(_ center: CGPoint, animated: Bool)
    {
        var newContentOffset = self.contentOffset

        if self.contentSize.width > self.bounds.size.width {
            newContentOffset.x = max(0.0, (center.x * self.zoomScale) - (self.bounds.size.width / 2.0))
            newContentOffset.x = min(newContentOffset.x,
                                     (self.contentSize.width - self.bounds.size.width))
        }
        if self.contentSize.height > self.bounds.size.height {
            newContentOffset.y = max(0.0, (center.y * self.zoomScale) - (self.bounds.size.height / 2.0))
            newContentOffset.y = min(newContentOffset.y,
                                     (self.contentSize.height - self.bounds.size.height))
        }

        self.setContentOffset(newContentOffset, animated: animated)
    }
}
