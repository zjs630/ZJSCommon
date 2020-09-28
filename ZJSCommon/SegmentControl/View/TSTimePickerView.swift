//
//  TSTimePickerView.swift
//  tsbbt
//
//  Created by ZhangJingshun on 2020/9/21.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

class TSTimePickerView: UIView {

    
    private lazy var timePicker:UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    private var beginTimeStr = ""
    private var endTimeStr = ""

    private let beginTime: [String] = ["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00",
                               "08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00",
                               "16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    private let endTime: [String] = ["01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00",
                             "09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00",
                             "17:00","18:00","19:00","20:00","21:00","22:00","23:00","24:00",]

    var timeHasChanged: ((_ date: String) -> Void)!
    var timeHasSeleced: (() -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func pickerTime(_ time: String) {
        let array = time.components(separatedBy: "-")
        if array.count == 2 {
            let beginIndex = beginTime.firstIndex(of: array[0]) ?? 0
            beginTimeStr = beginTime[beginIndex]
            timePicker.selectRow(beginIndex, inComponent: 0, animated: true)
            
            let endIndex = endTime.firstIndex(of: array[1])  ?? 0
            endTimeStr = endTime[endIndex]
            timePicker.selectRow(endIndex, inComponent: 1, animated: true)
            timePicker.reloadAllComponents()
        }
    }
    
    
    // MARK: - 私有方法
    @objc private func removeView() {
        removeFromSuperview()
        timeHasSeleced?()
    }

    private func checkTime() {
        let begin = timePicker.selectedRow(inComponent: 0)
        let end = timePicker.selectedRow(inComponent: 1)
        if end < begin {
            timePicker.selectRow(begin, inComponent: 1, animated: true)
            endTimeStr = endTime[begin]
        }
        timeHasChanged("\(beginTimeStr)-\(endTimeStr)")
    }

}

extension TSTimePickerView {
    private func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeView))
        addGestureRecognizer(tap)
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        timePicker.backgroundColor = .white
        addSubview(timePicker)
        timePicker.snp.makeConstraints { (m) in
            m.left.right.equalTo(0)
            m.height.equalTo(216)
            m.bottom.equalTo(0)
        }
    }
}

extension TSTimePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return beginTime[row]
        } else if component == 1 {
            return endTime[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            beginTimeStr = beginTime[row]
        } else if component == 1 {
            endTimeStr = endTime[row]
        }
        checkTime()
    }
}

extension TSTimePickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 24
    }
}
