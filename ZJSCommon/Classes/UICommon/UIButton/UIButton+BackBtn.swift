//
//  UIButton+Extensions.swift
//  ZWeiBo
//
//  Created by ZhangJingshun on 2017/1/18.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit

extension UIButton {
    // MARK: - 返回按钮的类方法
    
    /// 自定义的返回按钮
    ///
    /// - Parameter title: 按钮文字
    /// - Returns: 返回一个UIButton
    class func zjsBackWithTextButton(_ title:String = "返回") -> UIButton {
        
        //创建按钮
        let btn = UIButton()
        
        btn.setTitle(title, for: .normal) //设置按钮上面的文字
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16) //设置字体大小
        
        //设置按钮文字的 默认和选中字体颜色
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        
        //设置文字左侧的小图片
        let imageName = "nav_back_withtext"
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_pressed"), for: .highlighted)
        
        btn.sizeToFit() //size自动适应内容的大小
        return btn
    }
    
    
    /// 自定义的返回按钮带target，anction
    ///
    /// - Parameters:
    ///   - title:  按钮文字
    ///   - target:  响应目标
    ///   - action:  要执行的方法
    /// - Returns: 返回一个UIButton
    class func zjsBackWithTextButton(_ title:String = "返回",target: Any?, action: Selector) -> UIButton {
        let btn = zjsBackWithTextButton(title)
        
        //添加按钮点击事件
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        //btn.layer.borderColor = UIColor.red.cgColor
        //btn.layer.borderWidth = 1.0 //默认边框为0
        
        return btn
    }    
}
