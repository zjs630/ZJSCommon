//
//  ChangeCityHeaderView.swift
//  tsbbtClient
//
//  Created by ZhangJingshun on 2020/8/12.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

class ChangeCityHeaderView: MyBaseView {
    let nzzkLabel = UILabel.ts_fontLabel(text: "您正在看", font: UIFont.systemFont(ofSize: 13, weight: .medium), color: UIColor(0x333337), bgColor: .white)
    let selectedLabel = UIButton.ts_button(text: "", textColor: 0x78797A, font: UIFont.systemFont(ofSize: 15, weight: .medium), bgColor: 0xF6F6F6, corner: 4)
    
    let currentWordLabel = UILabel.ts_fontLabel(text: "当前定位", font: UIFont.systemFont(ofSize: 13, weight: .medium), color: UIColor(0x333337), bgColor: .white)
    let currentLoactionLabel = UILabel.ts_fontLabel(font: UIFont.systemFont(ofSize: 15, weight: .medium), color: UIColor(0xFBA000))
    
    /// 城市定位视图
    let cornerView = UIView.ts_colorView(color: 0xFFF8E5, corner: 4)
    
    
    func updateUI(selected city1: String, location cityOrStatus: String?) {
        selectedLabel.setTitle(city1, for: .normal)
        if let city = cityOrStatus {
            currentLoactionLabel.text = city
        } else {
            currentLoactionLabel.text = "定位失败，请重试"
        }
    }
        
}

extension ChangeCityHeaderView {
    override func setupUI() {
        backgroundColor = .white
        // 1 您正在看
        addSubview(nzzkLabel)
        nzzkLabel.snp.makeConstraints { (m) in
            m.left.equalTo(15)
            m.top.equalTo(25-4)
            m.height.equalTo(21)
        }
        // 2 选择的城市
        selectedLabel.isEnabled = false
        selectedLabel.contentEdgeInsets = UIEdgeInsets(top: 6, left: 26, bottom: 6, right: 26)
        addSubview(selectedLabel)
        selectedLabel.snp.makeConstraints { (m) in
            m.left.equalTo(15)
            m.top.equalTo(48)
            m.height.equalTo(32)
        }
        // 3 当前定位文字
        addSubview(currentWordLabel)
        currentWordLabel.snp.makeConstraints { (m) in
            m.left.equalTo(15)
            m.top.equalTo(100)
        }
        // 4 定位位置
        addSubview(cornerView)
        cornerView.snp.makeConstraints { (m) in
            m.top.equalTo(123)
            m.left.equalTo(15)
            m.height.equalTo(32)
            m.width.lessThanOrEqualTo(280).priority(.low)
        }
        let imgView = UIImageView(image: UIImage(named: "home_location"))
        cornerView.addSubview(imgView)
        imgView.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.left.equalTo(13)
        }
        currentLoactionLabel.isUserInteractionEnabled = false
        cornerView.addSubview(currentLoactionLabel)
        currentLoactionLabel.snp.makeConstraints { (m) in
            m.left.equalTo(imgView.snp.right).offset(5)
            m.centerY.equalToSuperview()
            m.right.equalTo(-15)
        }
    }
}
