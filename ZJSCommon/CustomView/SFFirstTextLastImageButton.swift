//
//  SFFirstTextLastImageButton.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2017/7/17.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit

// 应用场景，用户名后面跟一个编辑图片
/// 自定义按钮，文字在前，图片在后
class SFFirstTextLastImageButton: SFSelectedAlphaButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        //设置字体和颜色
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        titleLabel?.lineBreakMode = .byTruncatingTail
        setTitleColor(UIColor.darkGray, for: .normal)
       
        setTitleColor(.white, for: .normal)
        //设置大小
        sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(imageName normal:String, title text:String, font size:CGFloat = 12,textColor: UIColor? = .white) {
        self.init()
        //设置字体
        titleLabel?.font = UIFont.systemFont(ofSize: size)
        //设置文本
        setTitle(text, for: .normal)
        //设置文本颜色
        setTitleColor(textColor, for: .normal)
        //设置图像
        setImage(UIImage(named:normal), for: .normal)
        //设置大小
        sizeToFit()
        
    }

    //重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleLabel = titleLabel,
            let imageView = imageView else {
                return
        }
        
        let x = imageView.frame.origin.x
        if x<titleLabel.frame.origin.x {
            titleLabel.frame.origin.x = x
            imageView.frame.origin.x = titleLabel.frame.width + x
        }
        
    }
}
