//
//  DateSelectView.swift
//  tsbbt
//
//  Created by ZhangJingshun on 2020/9/16.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit
import SnapKit

protocol DateSelectViewDelegate: NSObject {
    func dateSelected(date: String)
    func timeSelected(time: String)
}

/// 日期选择View
class DateSelectView: UIView {

    weak var delegate: DateSelectViewDelegate?
    private let dateBtn = UIButton.ts_button(text: Date.ts_todayString(), textColor: 0x4285F4, font: UIFont.systemFont(ofSize: 12))
    private let timeBtn = UIButton.ts_button(text: "06:00-21:00", textColor: 0x4285F4, font: UIFont.systemFont(ofSize: 12))

    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func dateBtnPressed() {
        delegate?.dateSelected(date: dateBtn.titleLabel?.text ?? "")
    }
    @objc private func timeBtnPressed() {
        delegate?.timeSelected(time: timeBtn.titleLabel?.text ?? "")
    }
    // MARK: - 外部调用
    
    /// 设置日期
    func setDate(width date: String) {
        dateBtn.setTitle(date, for: .normal)
    }
    /// 设置时间
    func setTime(width time: String) {
        timeBtn.setTitle(time, for: .normal)
    }
    /// 获取服务器需要的日期参数
    func beginEndDate() -> (begin: String, end: String) {
        if let date = dateBtn.titleLabel?.text, let time = timeBtn.titleLabel?.text {
            let array = time.components(separatedBy: "-")
            if array.count == 2 {
                let beginTime = "\(date) \(array[0]):00"
                let endTime = "\(date) \(array[1]):00"
                return (beginTime, endTime)
            }
        }
        let todayDate = Date.ts_todayString()
        return ("\(todayDate) 06:00:00","\(todayDate) 21:00:00")
    }
}

extension DateSelectView {
    func setupUI() {
        // 圆角圆框
        let cornerBGView = UIView.ts_borderView(color: 0x4285F4, corner: 10)
        addSubview(cornerBGView)
        cornerBGView.snp.makeConstraints { (m) in
            m.top.bottom.equalTo(0)
            m.left.equalTo(20)
            m.right.equalTo(-20)
        }
        // 中线
        let centerLineView = UIView.ts_colorView(color: 0x4285F4)
        addSubview(centerLineView)
        centerLineView.snp.makeConstraints { (m) in
            m.width.equalTo(1/UIScreen.main.scale)
            m.top.bottom.equalTo(0)
            m.centerX.equalToSuperview()
        }
        // 日期按钮
        dateBtn.addTarget(self, action: #selector(dateBtnPressed), for: .touchUpInside)
        cornerBGView.addSubview(dateBtn)
        dateBtn.snp.makeConstraints { (m) in
            m.left.top.bottom.equalTo(0)
            m.right.equalTo(cornerBGView.snp.centerX).offset(0)
        }
        // 时间
        timeBtn.addTarget(self, action: #selector(timeBtnPressed), for: .touchUpInside)
        cornerBGView.addSubview(timeBtn)
        timeBtn.snp.makeConstraints { (m) in
            m.left.equalTo(centerLineView.snp.right)
            m.right.equalTo(0)
            m.centerY.equalToSuperview()
        }
    }
}
