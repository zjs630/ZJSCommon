//
//  UpImageDownTextButton.swift
//  ZJSCommon
//
//  Created by JingshunZhang on 2017/5/18.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit
import Foundation

/* 示例代码
 let btn = UpImageDownTextButton(imageName: "imgName", title: "text" )
 // frame高度 >= 图片高度 + 文字高度, frame宽度要 > 图片和文字的宽度
 btn.frame = CGRect(x:x, y:360, width: 60, height: 60)
 btn.addTarget(self, action: #selector(btnPrint), for: .touchUpInside)
 view.addSubview(btn)
 */

// 加透明度整体效果会好一些，如果不要透明度，可继承UIButton
/// 自定义一个按钮，图片在上，文字在下，点击整体透明度为60%
class UpImageDownTextButton: SFSelectedAlphaButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitle("圈子", for: .normal)
        //设置字体和颜色
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
        titleLabel?.textAlignment = .center
        setTitleColor(UIColor.darkGray, for: .normal)
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
        
        // 图片在上面
        imageView.frame = CGRect(x: (vW-imgW)/2, y: 0, width: imgW, height: imgH)
        // 文字在图片的下面
        titleLabel.frame = CGRect(x: 0, y: imgH, width: vW, height: vH-imgH)
        
    }


}
