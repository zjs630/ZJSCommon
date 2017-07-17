//
//  SFFirstTextLastImageButton.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2017/7/17.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit

class SFFirstTextLastImageButton: SFSelectedAlphaButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setTitle("首页" + " ", for: .normal) //加空格是为了设置图片和文字的间距

        //设置字体和颜色
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        titleLabel?.lineBreakMode = .byTruncatingTail
        setTitleColor(UIColor.darkGray, for: .normal)
       
        let imageName = "nav_edit_button"
        setImage(UIImage(named:imageName), for: .normal)
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
