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
//  TiledVisibleAnnotationTuple
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class TiledVisibleAnnotationTuple.swift
// @abstract 碎片地图可视位置
// @discussion 设置碎片地图可视范围
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

class TiledVisibleAnnotationTuple: NSObject
{
    var annotation: TiledAnnotation!
    var view: TiledAnnotationView!

    convenience init(annotation: TiledAnnotation, view: TiledAnnotationView)
    {
        self.init()
        self.annotation = annotation
        self.view = view
    }
}

extension Set
{
    //NSSet {

    func visibleAnnotationTupleForAnnotation(_ annotation: TiledAnnotation) -> TiledVisibleAnnotationTuple?
    {
        for obj in self {
            if let t = obj as? TiledVisibleAnnotationTuple {
                if t.annotation === annotation {
                    return t
                }
            }
        }
        return nil
    }

    func visibleAnnotationTupleForView(_ view: TiledAnnotationView) -> TiledVisibleAnnotationTuple?
    {
        for obj in self {
            if let t = obj as? TiledVisibleAnnotationTuple {
                if t.view === view {
                    return t
                }
            }
        }
        return nil
    }
}
