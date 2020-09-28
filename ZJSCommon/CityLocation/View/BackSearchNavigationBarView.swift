//
//  BackSearchNavigationBarView.swift
//  tsbbtClient
//
//  Created by ZhangJingshun on 2020/8/12.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit


/// 带返回箭头的渐变色导航条
class BaseColorNavigationBarView: MyBaseView {
    let backBtn = UIButton.ts_imageButton(name: "navi_back")
    let bgImageView = UIImageView()
    
    override func setupUI() {
        // 1. 背景色View 包含状态栏和导航栏的高度
        bgImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.topSafeHight)
        bgImageView.image = UIImage(named: "navi_background")
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        // 2.
        backBtn.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.bottom.equalTo(0)
            make.width.height.equalTo(44)
        }
    }
    @objc private func popViewController() {
        UIApplication.shared.currentNavigationController?.popViewController(animated: true)
    }
}

/// 带返回箭头的黄色渐变导航条，增加<-搜索-> 
class BackSearchNavigationBarView: BaseColorNavigationBarView {
    let searchBar = SearchTextField(placeholder:"搜索城市")
}

extension BackSearchNavigationBarView {
    override func setupUI() {
        super.setupUI()
        addSubview(searchBar)
        searchBar.snp.makeConstraints { (m) in
            m.left.equalTo(50)
            m.right.equalTo(-15)
            m.bottom.equalTo(-7)
            m.height.equalTo(30)
        }
    }
}

/// 透明色导航条样式 // 帮友等级页面用到
class BackClearNavigationBarView: MyBaseView {
    let backBtn = UIButton.ts_imageButton(name: "nav_back_white")
    let titleLabel = UILabel.ts_myLabel(font: 18, color: .white)
    
    convenience init(title: String) {
        self.init()
        self.titleLabel.text = title
    }
    
    override func setupUI() {
        // 1. 标题
        backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height/2)
            m.centerX.equalToSuperview()
        }
        // 2.返回按钮
        backBtn.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.bottom.equalTo(0)
            make.width.height.equalTo(44)
        }
    }
    @objc private func popViewController() {
        UIApplication.shared.currentNavigationController?.popViewController(animated: true)
    }
}
