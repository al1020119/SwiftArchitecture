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
//  TiledView
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class TiledView.swift
// @abstract 碎片地图View
// @discussion 显示位图碎片地图
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit
import QuartzCore

@objc protocol TiledViewDelegate {

}

@objc protocol TiledBitmapViewDelegate: TiledViewDelegate {
    
    func tiledView(_ tiledView: TiledView, imageForRow row: Int, column: Int, scale: Int) -> UIImage
}

let kTiledDefaultTileSize: CGFloat = 256.0

class TiledView: UIView
{
    weak var delegate: TiledViewDelegate?

    var tileSize: CGSize = CGSize(width: kTiledDefaultTileSize, height: kTiledDefaultTileSize)
    {
        didSet
        {
            let scaledTileSize = self.tileSize.applying(CGAffineTransform(scaleX: self.contentScaleFactor, y: self.contentScaleFactor))
            self.tiledLayer().tileSize = scaledTileSize
        }
    }

    var shouldAnnotateRect: Bool = false

    var numberOfZoomLevels: size_t
    {
        get
        {
            return self.tiledLayer().levelsOfDetailBias
        }
        set
        {
            self.tiledLayer().levelsOfDetailBias = newValue
        }
    }

    func tiledLayer() -> TiledLayer
    {
        return self.layer as! TiledLayer
    }

    override class var layerClass : AnyClass
    {
        return TiledLayer.self
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        let scaledTileSize = self.tileSize.applying(CGAffineTransform(scaleX: self.contentScaleFactor, y: self.contentScaleFactor))
        self.tiledLayer().tileSize = scaledTileSize
        self.tiledLayer().levelsOfDetail = 1
        self.numberOfZoomLevels = 3
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        let scale = ctx.ctm.a / tiledLayer().contentsScale

        let col = Int(rect.minX * scale / tileSize.width)
        let row = Int(rect.minY * scale / tileSize.height)

        if let tileImage = (delegate as? TiledBitmapViewDelegate)?.tiledView(self, imageForRow: row, column: col, scale: Int(scale)) {
            tileImage.draw(in: rect)
        }

        if shouldAnnotateRect {
            annotateRect(rect, inContext: ctx)
        }
    }

    // Handy for Debug
    func annotateRect(_ rect: CGRect, inContext ctx: CGContext)
    {
        let scale = ctx.ctm.a / self.tiledLayer().contentsScale
        let lineWidth = 2.0 / scale
        let fontSize = 16.0 / scale

        UIColor.white.set()
        NSString.localizedStringWithFormat(" %0.0f", log2f(Float(scale))).draw(
        at: CGPoint(x: rect.minX, y: rect.minY),
        withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]
        )

        UIColor.red.set()
        ctx.setLineWidth(lineWidth)
        ctx.stroke(rect)
    }
}

