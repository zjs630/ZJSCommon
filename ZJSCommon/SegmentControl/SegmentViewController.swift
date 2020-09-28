//
//  SegmentViewController.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2020/9/28.
//  Copyright © 2020 ix86. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController {
    
    let segmentedControl = MySegmentedControl(left: "帮友", right: "店铺")
    let leftView = UIView.ts_colorView(color: 0xFF0000, corner: 10)
    let rightView = UIView.ts_colorView(color: 0x0000FF, corner: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSegmentControl()
        leftView.frame = CGRect(x: 20, y: UIScreen.topSafeHight + 64, width: UIScreen.width - 40, height: 100)
        view.addSubview(leftView)
        rightView.frame = CGRect(x: 20, y: UIScreen.topSafeHight + 64, width: UIScreen.width - 40, height: 100)
        rightView.isHidden = true
        view.addSubview(rightView)
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
