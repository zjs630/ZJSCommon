//
//  Button.swift
//  tsbbt
//
//  Created by liu on 2020/6/16.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

extension UIButton {
    /// 快速创建图片按钮的工厂方法 （图片高亮效果，图片名以_highlight结尾）
    /// - Parameter name: 图片名
    /// - Returns: 按钮
    static func ts_imageButton(name: String) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: name), for: .normal)
        let highlightedStr = name.appending("_highlight")
        btn.setImage(UIImage(named: highlightedStr), for: .highlighted)
        return btn
    }

    /// 快速创建文字按钮的工厂方法 默认17号字，黑色，白背景
    static func ts_button(text: String, textColor: UInt32 = 0x0,font:UIFont = UIFont.systemFont(ofSize: 17), bgColor: UInt32 = 0xFFFFFF, corner cSize: CGFloat = 0) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.setTitle(text, for: .normal) // 文字 默认黑色
        btn.setTitleColor(UIColor(textColor), for: .normal) // 颜色
        btn.titleLabel?.font = font // 字体
        btn.backgroundColor = UIColor(bgColor) // 默认白色背景
        if cSize > 0 {
            btn.layer.cornerRadius = cSize
            btn.layer.masksToBounds = true
        }
        return btn
    }

}
