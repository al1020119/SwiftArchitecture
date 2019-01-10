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
//  UIScrollView+AppTools
//
//  Created by iCocos on 2018/12/28.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class UIScrollView+AppTools.swift
// @abstract 滑动工具
// @discussion 实现tableView-ScrollView服务
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

extension AppTools where Base: UIScrollView {
    /// 注册 Table View / Collection View 的 Cell
    ///
    /// - Parameter cellClass: Cell 类
    public func registerNibCell(with cellClass: AnyClass) {
        if let nibName = string(from: cellClass) {
            let cellNib = UINib(nibName: nibName, bundle: nil)

            if let tableView = base as? UITableView {
                tableView.register(cellNib, forCellReuseIdentifier: nibName)
            } else if let collectionView = base as? UICollectionView {
                collectionView.register(cellNib, forCellWithReuseIdentifier: nibName)
            }
        }
    }

    /// 注册 Table View 的 Header / Footer
    ///
    /// - Parameter viewClass: Header / Footer 类
    public func registerNibHeaderFooter(with viewClass: AnyClass) {
        if let nibName = string(from: viewClass) {
            let nib = UINib(nibName: nibName, bundle: nil)

            if let tableView = base as? UITableView {
                tableView.register(nib, forHeaderFooterViewReuseIdentifier: nibName)
            }
        }
    }

    /// 为 Table View / Collection View 分配可重用的 Cell
    ///
    /// - Parameters:
    ///   - cellClass: Cell 类
    ///   - indexPath: Cell 的索引
    /// - Returns: 分配的 Cell
    public func dequeueReusableCell(with cellClass: AnyClass, indexPath: IndexPath? = nil) -> Any? {
        if let nibName = string(from: cellClass)  {
            if let tableView = base as? UITableView {
                guard let `indexPath` = indexPath else {
                    return tableView.dequeueReusableCell(withIdentifier: nibName)
                }
                return tableView.dequeueReusableCell(withIdentifier: nibName, for: `indexPath`)
            } else if let collectionView = base as? UICollectionView {
                guard let `indexPath` = indexPath else {
                    return UICollectionView()
                }
                return collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: `indexPath`)
            }
        }
        return nil
    }

    /// 为 Table View 分配可重用的 Header / Footer View
    ///
    /// - Parameter viewClass: Header / Footer 类
    /// - Returns: 分配的 Header / Footer View
    public func dequeueReusableHeaderFooterView(with viewClass: AnyClass) -> Any? {
        guard let nibName = string(from: viewClass) else { return nil }
        guard let tableView = base as? UITableView else { return nil }
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: nibName)
    }

    /// 描述类名的字符串
    ///
    /// - Parameter className: 要转换成字符串的类
    /// - Returns: 转换后的字符串
    private func string(from className: AnyClass) -> String? {
        let desc = className.description()
        guard desc.contains(".") else {
            return desc
        }
        return desc.components(separatedBy: ".").last
    }
}
