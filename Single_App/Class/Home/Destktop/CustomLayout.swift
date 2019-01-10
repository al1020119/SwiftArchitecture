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
//  CustomLayout
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class CustomLayout.swift
// @abstract CustomLayout自定义布局
// @discussion 自定义布局控制
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************//

import UIKit

protocol CustomLayoutDataSource: class {
    func numberOfCols(_ customLayout: CustomLayout) -> Int
    func numberOfRols(_ customLayout: CustomLayout) -> Int
}

class CustomLayout: UICollectionViewFlowLayout {
    
    weak var dataSource: CustomLayoutDataSource?
    
    fileprivate lazy var rols: Int? = {
       return self.dataSource?.numberOfRols(self)
    }()
    
    fileprivate lazy var cols: Int? = {
        return self.dataSource?.numberOfCols(self)
    }()
    
    fileprivate lazy var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//        let page = indexPath.item%(rols*cols) == 0 ? indexPath.item/(rols*cols) : (indexPath.item/(cols*rols) + 1)
        guard let rols = dataSource?.numberOfRols(self), let cols = dataSource?.numberOfCols(self) else {
            fatalError("请实现对应的数据源方法(行数和列数)")
        }
        let page = indexPath.item / (cols * rols)//页数
        let cellW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(cols - 1) * minimumInteritemSpacing)) / CGFloat(cols)
        let itemRow = CGFloat((indexPath.item - page*(cols*rols)) / cols)//行数
        let itemCol = CGFloat((indexPath.item - page*(cols*rols)) % cols)//列数
        let cellX = CGFloat(page) * collectionView!.bounds.width + CGFloat(itemCol) * (cellW + 10) + sectionInset.left
        let cellH: CGFloat = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - (CGFloat(rols - 1)) * minimumLineSpacing) / CGFloat(rols)
        let cellY = itemRow * (cellH + sectionInset.top) + sectionInset.top
        attribute.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
        return attribute
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        for i in 0..<itemCount {
            let attr = layoutAttributesForItem(at: IndexPath(item: i, section: 0))
            attrsArray.append(attr!)
        }
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        guard let rols = dataSource?.numberOfRols(self), let cols = dataSource?.numberOfCols(self) else {
            fatalError("请实现对应的数据源方法(行数和列数)")
        }
        let page = itemCount%(cols*rols) == 0 ? itemCount/(cols*rols) : itemCount/(cols*rols) + 1
        
        return CGSize(width: CGFloat(page) * collectionView!.bounds.width, height: 0)
    }
}
