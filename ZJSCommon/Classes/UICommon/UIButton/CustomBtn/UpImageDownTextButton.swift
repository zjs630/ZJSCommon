//
//  UpImageDownTextButton.swift
//  ZJSCommon
//
//  Created by JingshunZhang on 2017/5/18.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit
import Foundation

class UpImageDownTextButton: SFSelectedAlphaButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("应援", for: .normal)
        //设置字体和颜色
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        titleLabel?.textAlignment = .center
        setTitleColor(UIColor.darkGray, for: .normal)
        
        //设置图像
        //setImage(UIImage(named:"fansupport"), for: .normal)
        
        //设置大小
        sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(imageName normal:String, title text:String, font size:CGFloat = 12) {
        self.init()
        //设置字体
        titleLabel?.font = UIFont.systemFont(ofSize: size)
        //设置文本
        setTitle(text, for: .normal)
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

        let imgH = imageView.bounds.height
        let imgW = imageView.bounds.width
        let vH = bounds.height
        let vW = bounds.width
        
        imageView.frame = CGRect(x: (vW-imgW)/2, y: 0, width: imgW, height: imgH)
        titleLabel.frame = CGRect(x: 0, y: imgH, width: vW, height: vH-imgH)
        
    }


}
