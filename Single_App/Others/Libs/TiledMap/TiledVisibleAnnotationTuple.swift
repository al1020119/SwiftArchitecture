//
//  Copyright (c) 2015-present Yichi Zhang
//  https://github.com/yichizhang
//  zhang-yi-chi@hotmail.com
//
//  This source code is licensed under MIT license found in the LICENSE file
//  in the root directory of this source tree.
//  Attribution can be found in the ATTRIBUTION file in the root directory 
//  of this source tree.
//

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
