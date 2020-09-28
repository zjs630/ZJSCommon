//
//  HomeNavigationBarView.swift
//  tsbbtClient
//
//  Created by zjs on 2020/7/27.
//  Copyright © 2020 tawy. All rights reserved.
//


import UIKit
import SnapKit

/// 我的页面导航条（高度包含状态栏，仅显示两个按钮）
class HomeNavigationBarView: MyBaseView {
    /// 定位图标
    let locationImageView = UIImageView(image: UIImage(named: "nav_location"))
    /// 城市定位按钮
    let cityBtn = TSCustomButton() // IUButton(false, iu: false)
    
    let bgView = UIView()
    
    func setCity(text: String) {
        cityBtn.titleLabel.text = text
    }
    
}

extension HomeNavigationBarView {
    
    override func setupUI() {
        // 1. 背景色View 包含状态栏和导航栏的高度
        bgView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.topSafeHight)
        bgView.backgroundColor = UIColor(0xFFBA00)
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }

        locationImageView.isUserInteractionEnabled = true
        addSubview(locationImageView)
        locationImageView.snp.makeConstraints { (maker) in
            maker.left.equalTo(13)
            maker.centerY.equalToSuperview().offset(UIScreen.statusBarHight/2)
        }
        
        cityBtn.imageView.image = UIImage(named: "home_down")
        cityBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cityBtn.titleLabel.textColor = .black
        cityBtn.titleLabel.text = "text"
        cityBtn.titlePostion = .left(2)
        addSubview(cityBtn)
        cityBtn.snp.makeConstraints { (make) in
            make.left.equalTo(locationImageView.snp.right).offset(4)
            make.top.equalTo(UIScreen.statusBarHight)
            make.height.equalTo(44)
        }
        
    }

}
