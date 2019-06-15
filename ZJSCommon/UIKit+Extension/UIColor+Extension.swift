//
//  UIColor+Extension.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2019/6/14.
//  Copyright © 2019 ix86. All rights reserved.
//

import Foundation


extension UIColor {
    /// 生成一个颜色
    ///
    /// - Parameters:
    ///   - hex: 十六进制的RGB值
    ///   - alpha: 透明度
    convenience init(rgb hex: UInt32, a alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: r, green: g, blue: b, alpha: alpha)
        } else {
            self.init(red: r, green: g, blue: b, alpha: alpha)
        }

    }
    
    /// 生成一个颜色
    ///
    /// - Parameters:
    ///   - r: 十进制的红色值
    ///   - g: 十进制的绿色值
    ///   - b: 十进制的蓝色值
    ///   - a: 透明度
    convenience init(r red: UInt32, g green: UInt32, b blue: UInt32, a: CGFloat = 1) {
        let r = CGFloat(red) / 255.0
        let g = CGFloat(green) / 255.0
        let b = CGFloat(blue) / 255.0

        if #available(iOS 10.0, *) {
            self.init(displayP3Red: r, green: g, blue: b, alpha: a)
        } else {
            self.init(red: r, green: g, blue: b, alpha: a)
        }
    }
    
    ///  随机颜色（常用于测试UI）
    ///
    /// - Returns: 返回一个随机颜色
    static func js_randomColor() -> UIColor {
        let r = UInt32.random(in: 0..<256)
        let g = UInt32.random(in: 0..<256)
        let b = UInt32.random(in: 0..<256)
        return UIColor(r: r, g: g, b: b)
    }
}
