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
//  DestktopViewController
//
//  Created by iCocos on 2019/01/06.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class DestktopViewController.swift
// @abstract 自定义layout
// @discussion 自定义layout布局效果首页桌面
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************//

import UIKit
import SwiftyAttributes

class DestktopViewController: UIViewController {

    let topspacing:CGFloat = 10
    let spacing:CGFloat = 30
    let kWidth:CGFloat = UIScreen.main.bounds.width
    let kHeight:CGFloat = UIScreen.main.bounds.height
    
    let itemSize = (UIScreen.main.bounds.width - 30*4)/3
    
    let collectionHeight:CGFloat = (UIScreen.main.bounds.width - 30*4)/3 * 2 + 50

    fileprivate lazy var backImage: UIImageView = {
        let backImage = UIImageView()
        backImage.image = UIImage(named: "homebackimage")
        backImage.frame = self.view.bounds
        return backImage
    }()
    fileprivate lazy var topStatusBar: DestktopStatusBar = {
        let topStatusBar = DestktopStatusBar.loadFromNib()
        topStatusBar.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30)
        topStatusBar.batteryValuePercentage.text = "%\(AppConfigInfo.currentBatteryPercent())"
        return topStatusBar
    }()
    
    fileprivate lazy var desktime: UILabel = {
        let desktime = UILabel()
        desktime.frame = CGRect.init(x: 80, y: 80, width: UIScreen.main.bounds.size.width - 160, height: 100)
        desktime.textAlignment = .center
        desktime.numberOfLines = 2
        desktime.textColor = .white
        let time = AppConfigInfo.currentTimeString()
        let data = AppConfigInfo.currentDataWeekString()
        let fancyString = "\(time)\n".withFont(.systemFont(ofSize: 50)) + "\(data)".withFont(.systemFont(ofSize: 16))
        desktime.attributedText = fancyString
        return desktime
    }()
    
    /// CollectionView
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout = CustomLayout()
        layout.dataSource = self
        layout.sectionInset = UIEdgeInsets(top: topspacing, left: spacing, bottom: topspacing, right: spacing)
        //layout.minimumLineSpacing = 30, layout.minimumInteritemSpacing = 30
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        
        let rect = CGRect(x: 0, y: (kHeight - collectionHeight)/2 + 30, width: kWidth, height: collectionHeight)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "hehe")
        return collectionView
    }()
    
    fileprivate lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("返回手机", for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.setBackgroundColor(.red, forState: .normal)
        backButton.frame = CGRect.init(x: UIScreen.main.bounds.size.width-150, y: UIScreen.main.bounds.size.height-70, width: 120, height: 44)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        backButton.titleLabel?.textAlignment = .center
        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return backButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "首页"
        view.addSubview(backImage)
        view.addSubview(topStatusBar)
        view.addSubview(desktime)
        view.addSubview(collectionView)
        view.addSubview(backButton)
        
        print("---------------------statusBarInfo-------------------------\n")
        //print(AppConfigInfo.statusBarInfo())
        
        print("---------------------serviceCompany------------------------\n")
        print("运营商: \(AppConfigInfo.serviceCompany())")
        print("---------------------currentNetworkType--------------------\n")
        print("网络类型: \(AppConfigInfo.currentNetworkType())")
        print("--------------------currentBatteryPercent------------------\n")
        print("当前电量: \(AppConfigInfo.currentBatteryPercent())")
        
        print("---------------------currentTimeString---------------------\n")
        print("当前时间: \(AppConfigInfo.currentTimeString())")
        
        print("---------------------currentDataString---------------------\n")
        print("当前日期: \(AppConfigInfo.currentDataWeekString())")
        
        print("-----------------------------------------------------------\n")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /// 移除按钮点击
    ///
    /// - Parameter sender: 移除按钮
    @objc func buttonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        return
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DestktopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hehe", for: indexPath)
        cell.backgroundColor = UIColor.rendomColor()
        return cell
    }
}

extension DestktopViewController: CustomLayoutDataSource {
    func numberOfCols(_ customLayout: CustomLayout) -> Int {
        return 3
    }
    func numberOfRols(_ customLayout: CustomLayout) -> Int {
        return 2
    }
}

////定义每个Cell的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGSize size = CGSizeMake(80,80);
//    return size;
//｝
//
////定义每个Section的四边间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(15, 15, 5, 15);//分别为上、左、下、右
//}
//
////这个是两行cell之间的间距（上下行cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
//
////两个cell之间的间距（同一行的cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
