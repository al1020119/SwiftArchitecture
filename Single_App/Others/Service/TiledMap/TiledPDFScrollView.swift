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
//  TiledPDFScrollView
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class TiledPDFScrollView.swift
// @abstract PDF模式显示碎片地图
// @discussion 实现使用PDF方式加载碎片地图
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

class TiledPDFScrollView: TiledScrollView, TiledPDFViewDelegate
{
    fileprivate var document: CGPDFDocument!

    fileprivate var numberOfPages = Int(0)
    fileprivate var cropBoxRect = CGRect.zero
    fileprivate var mediaBoxRect = CGRect.zero
    fileprivate var effectiveRect = CGRect.zero

    override class func tiledLayerClass() -> AnyClass
    {
        return TiledPDFView.self
    }

    deinit
    {
        document = nil
    }

    init(frame: CGRect, URL url: URL)
    {
        var contentSize = CGSize.zero

        guard let tempDocument = TiledPDFDocument.createX(url, password: "") else {
            fatalError("Document is null")
        }
        document = tempDocument

        guard let firstPage = document.page(at: 1) else {
            fatalError("Page is null")
        }
        numberOfPages = document.numberOfPages
        cropBoxRect = firstPage.getBoxRect(CGPDFBox.cropBox);
        mediaBoxRect = firstPage.getBoxRect(CGPDFBox.mediaBox);
        effectiveRect = mediaBoxRect

        contentSize = CGSize(width: effectiveRect.size.width,
                             height: effectiveRect.size.height * CGFloat(numberOfPages))

        super.init(frame: frame, contentSize: contentSize)

        let preferredTileWidth = 256
        let preferredTileHeight = 256

        let cols = Int(effectiveRect.size.width) / preferredTileWidth + 1
        let rows = Int(effectiveRect.size.height) / preferredTileHeight + 1
        self.tiledView.tileSize = CGSize(width: effectiveRect.size.width / CGFloat(cols), height: effectiveRect.size.height / CGFloat(rows))

        let fitZoomScale = min(
        scrollView.bounds.width / effectiveRect.size.width,
        scrollView.bounds.height / effectiveRect.size.height
        )

        scrollView.minimumZoomScale = fitZoomScale
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    func pdfPageForTiledView(_ tiledView: TiledPDFView!, rect: CGRect, pageNumber: UnsafeMutablePointer<Int>, pageSize: UnsafeMutablePointer<CGSize>) -> CGPDFPage?
    {
        var requestedPage = Int(rect.origin.y / effectiveRect.height) + 1

        if requestedPage < 1 {
            requestedPage = 1
        }
        if requestedPage > numberOfPages {
            requestedPage = numberOfPages
        }

        pageNumber.pointee = requestedPage
        pageSize.pointee = effectiveRect.size

        return document.page(at: requestedPage)
    }

    func pdfDocumentForTiledView(_ tiledView: TiledPDFView!) -> CGPDFDocument
    {
        return document
    }
}

