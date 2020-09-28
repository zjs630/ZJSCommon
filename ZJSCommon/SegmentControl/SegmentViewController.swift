//
//  SegmentViewController.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2020/9/28.
//  Copyright © 2020 ix86. All rights reserved.
//

import UIKit
import SnapKit

class SegmentViewController: UIViewController {
    // MARK: -  分段控件
    let segmentedControl = MySegmentedControl(left: "帮友", right: "店铺")
    let leftView = UIView.ts_colorView(color: 0xFF0000, corner: 10)
    let rightView = UIView.ts_colorView(color: 0x0000FF, corner: 10)
    
    // MARK: - 日期选择控件
    let dateSelectView = DateSelectView()
    lazy var datePicker = TSDatePickerView()
    lazy var timePicker =  TSTimePickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 分段控件
        addSegmentControl()
        leftView.frame = CGRect(x: 20, y: UIScreen.topSafeHight + 64, width: UIScreen.width - 40, height: 100)
        view.addSubview(leftView)
        rightView.frame = CGRect(x: 20, y: UIScreen.topSafeHight + 64, width: UIScreen.width - 40, height: 100)
        rightView.isHidden = true
        view.addSubview(rightView)
        
        // 日期时间选择控件
        dateSelectView.delegate = self
        view.addSubview(dateSelectView)
        dateSelectView.snp.makeConstraints { (m) in
            m.top.equalTo(leftView.snp.bottom).offset(15)
            m.left.right.equalTo(0)
            m.height.equalTo(30)
        }

    }
    
    private func addSegmentControl() {
        segmentedControl.clicked = { [weak self] (sender: UIButton) in
            if sender.tag == 1 {
                self?.leftView.isHidden = false
                self?.rightView.isHidden = true
            } else if sender.tag == 2 {
                self?.leftView.isHidden = true
                self?.rightView.isHidden = false
            }
        }
        segmentedControl.frame = CGRect(x: 0, y: UIScreen.topSafeHight + 10, width: UIScreen.width, height: MySegmentedControl.h)
        view.addSubview(segmentedControl)
    }



}

// MARK: - DateSelectViewDelegate
extension SegmentViewController: DateSelectViewDelegate {
    func dateSelected(date: String) {
        showDatePicker(with:date)
    }
    
    func timeSelected(time: String) {
        showTimePicker(with: time)
    }
    
    // MARK:  私有方法
    /// 显示日期控件
    /// - Parameter date:格式 “2020-09-21”
    private func showDatePicker(with date: String) {
        if datePicker.superview == nil {
            datePicker.dateHasChanged = { (dateStr) in
                self.dateSelectView.setDate(width: dateStr)
            }
            datePicker.dateHasSeleced = {
                // self.reloadListData()
            }
            view.addSubview(datePicker)
            datePicker.snp.makeConstraints { (m) in
                m.top.equalTo(UIScreen.topSafeHight)
                m.left.right.equalTo(0)
                m.bottom.equalTo(-UIScreen.bottomSafeHight)
            }
        }
        if let date = Date.ts_Date2(string: date) {
            datePicker.pickerDate(date)
        }
    }
    
    /// 显示时间控件
    /// - Parameter time: 格式 “09:00-21:00”
    private func showTimePicker(with time: String) {
        if timePicker.superview == nil {
            timePicker.timeHasChanged = { (timeStr) in
                self.dateSelectView.setTime(width: timeStr)
            }
            timePicker.timeHasSeleced = {
                // self.reloadListData()
            }
            view.addSubview(timePicker)
            timePicker.snp.makeConstraints { (m) in
                m.top.equalTo(UIScreen.topSafeHight)
                m.left.right.equalTo(0)
                m.bottom.equalTo(-UIScreen.bottomSafeHight)
            }
        }
        timePicker.pickerTime(time)
    }
}
