//
//  BorderLabel.swift
//  CustomViewTest
//
//  Created by ZhangJingshun on 2018/7/12
//  Copyright © 2019 ix86. All rights reserved.
//

import UIKit

//自定义label，通过代码实现UI效果，减少UI切图,减少app体积
/// 可设置内边距，圆角，带1像素边框的label
class BorderLabel: UILabel {

    /// 设置文字和边框的间距
    var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    convenience init(text: String, color: UIColor, size: CGFloat = 17, corner: CGFloat = 3.0) {
        self.init()
        self.text = text
        textColor = color
        font = UIFont.systemFont(ofSize: size)
        
        layer.borderWidth = 1.0 / UIScreen.main.scale
        layer.borderColor = color.cgColor
        layer.cornerRadius = corner
        
        edgeInsets = UIEdgeInsets(top: corner, left: corner, bottom: corner, right: corner)
        sizeToFit()
    }
    
    /// 依据设定间距，重置Label自定义大小
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height += edgeInsets.top + edgeInsets.bottom
        newSize.width += edgeInsets.left + edgeInsets.right
        return newSize
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }

}
