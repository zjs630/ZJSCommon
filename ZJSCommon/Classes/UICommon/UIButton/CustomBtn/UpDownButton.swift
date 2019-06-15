//
//  UpDownButton.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2017/2/15.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit

/* 示例代码：
 // 将按钮添加到导航栏中间位置
 fileprivate func addUpDownButton() {
     let btn_updown = UpDownButton()
     btn_updown.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
     navigationItem.titleView = btn_updown
 }
 
 // 点击按钮图片切换不同的状态
 @objc private func clickTitleButton(btn:UIButton) {
    btn.isSelected = !btn.isSelected
 }

 */

//系统按钮默认的图片在文字的左边。
/// 自定义按钮，图片在文字后面。
class UpDownButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setTitle("首页" + " ", for: .normal) //加空格是为了设置图片和文字的间距

        //设置字体和颜色
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitleColor(UIColor.darkGray, for: .normal)
        
        //设置图像
        setImage(UIImage(named:"nav_arrow_button_down"), for: .normal)
        setImage(UIImage(named:"nav_arrow_button_up"), for: .selected)
        
        //设置大小
        sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleLabel = titleLabel,
            let imageView = imageView else {
                return
        }
        
        titleLabel.frame.origin.x = 0
        imageView.frame.origin.x = titleLabel.bounds.width
    }
    
}
