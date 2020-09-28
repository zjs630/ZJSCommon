//
//  TSDatePickerView.swift
//  tsbbt
//
//  Created by ZhangJingshun on 2020/9/21.
//  Copyright © 2020 tawy. All rights reserved.
//

import Foundation

class TSDatePickerView: UIView {
    
    lazy var datePicker:UIDatePicker = {
        let picker = UIDatePicker()
        picker.backgroundColor = .white
        picker.datePickerMode = .date
        picker.minimumDate = Date.ts_Date2(string: "2020-01-01")
        picker.maximumDate = Date()
        picker.locale = Locale(identifier: "zh_cn")
        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return picker
    }()

    var dateHasChanged: ((_ date: String) -> Void)!
    var dateHasSeleced: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        let dateStr = datePicker.date.toDateString()
        dateHasChanged(dateStr)
    }
    
    func pickerDate(_ date: Date) {
        datePicker.date = date
    }
    
    @objc private func removeView() {
        removeFromSuperview()
        dateHasSeleced?()
    }
}

extension TSDatePickerView  {
    private func setupUI() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeView))
        addGestureRecognizer(tap)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        addSubview(datePicker)
        datePicker.snp.makeConstraints { (m) in
            m.left.right.equalTo(0)
            m.height.equalTo(216)
            m.bottom.equalTo(0)
        }

        
    }
    
    
    
}
