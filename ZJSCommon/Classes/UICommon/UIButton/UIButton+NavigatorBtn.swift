//
//  NavigatorButton.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2017/2/13.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit



// MARK: - 导航栏上的按钮
extension UIButton {

    /// 返回按钮
    class func zjsBackButton() -> UIButton {
        //创建按钮
        let imageName = "nav_back_button"
        return self.zjsCreateImageBtn(imageName)
    }
    
    /// 编辑按钮
    class func zjsEditButton() -> UIButton {
        let imageName = "nav_edit_button"
        return self.zjsCreateImageBtn(imageName)
    }

    /// ok按钮
    class func zjsOkButton() -> UIButton {
        let imageName = "nav_ok_button"
        return self.zjsCreateImageBtn(imageName)
    }

    /// 评论发送按钮
    class func zjsCommontSendButton() -> UIButton {
        let imageName: String = "nav_send_button"
        return self.zjsCreateImageBtn(imageName)
    }

    /// 创建纯图片按钮
    ///
    /// - Parameter imageName: 图片名称
    /// - Returns: 返回图片按钮
    class func zjsCreateImageBtn(_ imageName:String) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_pressed"), for: .highlighted)
        
        btn.sizeToFit() //size自动适应内容的大小

        return btn
    }
}
