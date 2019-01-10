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
//  TiledPDFView
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class TiledPDFView.swift
// @abstract 碎片PDFView
// @discussion 用于显示碎片地图的PDFView
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

@objc protocol TiledPDFViewDelegate
{
    func pdfPageForTiledView(_ tiledView: TiledPDFView!, rect: CGRect, pageNumber: UnsafeMutablePointer<Int>, pageSize: UnsafeMutablePointer<CGSize>) -> CGPDFPage?

    func pdfDocumentForTiledView(_ tiledView: TiledPDFView!) -> CGPDFDocument
}

class TiledPDFView: TiledView
{
    override func draw(_ rect: CGRect)
    {
        let ctx = UIGraphicsGetCurrentContext()

        UIColor.white.setFill()
        ctx?.fill((ctx?.boundingBoxOfClipPath)!)

        var pageNumber = Int(0)
        var pageSize = CGSize.zero

        guard let delegate = self.delegate as? TiledPDFViewDelegate else {
            return
        }
        guard let page: CGPDFPage = delegate.pdfPageForTiledView(self,
                                                                 rect: rect,
                                                                 pageNumber: &pageNumber,
                                                                 pageSize: &pageSize) else {
            return
        }
        ctx?.translateBy(x: 0.0, y: CGFloat(pageNumber) * pageSize.height)

        ctx?.scaleBy(x: 1.0, y: -1.0)
        ctx?.setRenderingIntent(CGColorRenderingIntent.defaultIntent)
        ctx!.interpolationQuality = CGInterpolationQuality.default

        ctx?.drawPDFPage(page)
    }
}
