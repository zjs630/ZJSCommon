//
//  JSHairLine.swift
//  OnePixLineTest
//
//  Created by JingshunZhang on 2017/5/11.
//  Copyright © 2017年 JingshunZhang. All rights reserved.
//

import UIKit

//MARK: 设置x像素的线，用于StoryBoard或Xib中。

/// 在StoryBoard或Xib文件中，无论是宽度约束还是高度，都可以设置为x像素的线，适配Retina屏。

class SFXLineConstraint: NSLayoutConstraint {
    override func awakeFromNib() {
        constant = constant / UIScreen.main.scale
    }
}
