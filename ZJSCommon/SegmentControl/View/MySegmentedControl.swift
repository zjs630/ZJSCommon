//
//  MySegmentedControl.swift
//  tsbbtClient
//
//  Created by ZhangJingshun on 2020/9/27.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

/// 我的帮友页面，定制选择控件
class MySegmentedControl: UIView {
    
    // 样式
    private let margin: CGFloat = 15.0
    static let h: CGFloat = 44.0
    private let mainColor: UIColor = UIColor(0xFFBC06)
    
    private var friendBtn: UIButton!
    private var shopBtn: UIButton!
    
    private var leftTitle: String = ""
    private var rightTitle: String = ""
    
    var clicked: ((_ sender: UIButton) -> Void)?
        
    convenience init(left title1: String, right title2: String) {
        self.init(frame: .zero)
        leftTitle = title1
        rightTitle = title2
        setupUI()
    }
    
    @objc private func clickSegmentedControl(_ sender: UIButton) {
        sender.isSelected = true
        if sender.tag == 1 {
            friendBtn.backgroundColor = mainColor
            shopBtn.backgroundColor = .white
            shopBtn.isSelected = false
        } else if sender.tag == 2 {
            shopBtn.backgroundColor = mainColor
            friendBtn.backgroundColor = .white
            friendBtn.isSelected = false
        }
        clicked?(sender)
    }

}

extension MySegmentedControl {
    private func setupUI() {
        let titleView = UIView()
        let width: CGFloat = UIScreen.width - margin - margin
        let radius: CGFloat = Self.h / 2
        titleView.frame = CGRect(x: margin, y: 0.0, width: width, height: Self.h)
        titleView.layer.cornerRadius = radius
        titleView.layer.masksToBounds = true
        titleView.layer.borderColor = mainColor.cgColor
        titleView.layer.borderWidth = 1.0 / UIScreen.main.scale
        addSubview(titleView)
        
        friendBtn = segmentButton(title: leftTitle, tag: 1, bgColor: mainColor)
        friendBtn.isSelected = true
        friendBtn.frame = CGRect(x: 0, y: 0, width: width / 2, height: Self.h)
        titleView.addSubview(friendBtn)
        
        shopBtn = segmentButton(title: rightTitle, tag: 2, bgColor: .white)
        shopBtn.frame = CGRect(x: width / 2, y: 0, width: width / 2, height: Self.h)
        titleView.addSubview(shopBtn)
    }
    
    private func segmentButton(title: String, tag: Int, bgColor: UIColor) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.tag = tag
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor(0xFFBC06), for: .normal)
        btn.setTitleColor(UIColor.black, for: .selected)
        btn.setTitleColor(UIColor.black, for: [.highlighted, .selected])
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btn.addTarget(self, action: #selector(clickSegmentedControl), for: .touchUpInside)
        btn.clipsToBounds = true
        btn.backgroundColor = bgColor
        return btn
    }
    
}

