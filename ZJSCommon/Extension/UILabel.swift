//
//  Label.swift
//  tsbbt
//
//  Created by liu on 2020/6/16.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

public extension UILabel {
    convenience init(textColor color:UIColor,font:UIFont) {
        self.init()
        setText(color, font: font)
    }
    func setText(_ color:UIColor,font:UIFont) {
        self.textColor = color
        self.font = font
    }
    
    /// 创建一个Label
    /// - Parameters:
    ///   - text: 文本
    ///   - size: 字号
    ///   - corner: 圆角
    ///   - bgColor: 背景色 ，默认为透明背景色，从性能考虑，建议设置纯色背景
    ///   - number: 16进制的颜色 如： 0xff33cc
    static func ts_label(text: String = "",  font size: CGFloat = 14, isBlod: Bool = false, color: UIColor,
                         corner: CGFloat = 0, bgColor: UIColor? = UIColor.clear) -> UILabel{
        let textLabel = UILabel()
        textLabel.text = text
        if isBlod {
            textLabel.font = UIFont.boldSystemFont(ofSize: size)
        } else {
            textLabel.font = UIFont.systemFont(ofSize: size)
        }
        textLabel.textColor = color
        textLabel.backgroundColor = bgColor
        if corner > 0 {
            textLabel.layer.cornerRadius = corner
            textLabel.layer.masksToBounds = true
        }
        return textLabel
    }
    /// 快速创建一个简单Label
    static func ts_myLabel(text: String = "", font size: CGFloat, color: UIColor) -> UILabel {
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.font = UIFont.systemFont(ofSize: size)
        textLabel.textColor = color
        return textLabel
    }
    /// 创建一个指定UIFont字体的Label
    static func ts_fontLabel(text: String = "",  font: UIFont, color: UIColor = UIColor.black, bgColor: UIColor? = UIColor.clear) -> UILabel{
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.font = font
        textLabel.textColor = color
        textLabel.backgroundColor = bgColor
        return textLabel
    }
}

