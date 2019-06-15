//
//  BackButtonViewController.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2017/1/18.
//  Copyright © 2017年 ix86. All rights reserved.
//


// MARK: - 查看返回按钮样式的类

import UIKit

class BackButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        addMyButton()
        
        addUpDownButton()
    }


    @objc fileprivate func backPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension BackButtonViewController {
    
    fileprivate func addUpDownButton() {
        let btn_updown = UpDownButton()
        btn_updown.addTarget(self, action: #selector(clickTitleButton), for: .touchUpInside)
        navigationItem.titleView = btn_updown
    }
    
    @objc private func clickTitleButton(btn:UIButton) {
        btn.isSelected = !btn.isSelected
    }
    
    /// 添加各种样式的按钮
    fileprivate func addMyButton() {
        //返回按钮
        let btn_back = UIButton.zjsBackButton()
        btn_back.frame = CGRect(x: 20, y: 124, width: btn_back.bounds.width, height: btn_back.bounds.height)
        view.addSubview(btn_back)
        
        //编辑按钮
        let btn_edit = UIButton.zjsEditButton()
        btn_edit.frame = CGRect(x: 20, y: 160, width: btn_edit.bounds.width, height: btn_edit.bounds.height)
        view.addSubview(btn_edit)
        
        //ok按钮
        let btn_ok = UIButton.zjsOkButton()
        btn_ok.frame = CGRect(x: 20, y: 200, width: btn_ok.bounds.width, height: btn_ok.bounds.height)
        view.addSubview(btn_ok)
        
        //评论发送按钮
        let btn_send = UIButton.zjsCommontSendButton()
        btn_send.frame = CGRect(x: 20, y: 240, width: btn_send.bounds.width, height: btn_send.bounds.height)
        view.addSubview(btn_send)
        
        //评论发送按钮
        let btn_share = UIButton.zjsCreateImageBtn("nav_share_button")
        btn_share.frame = CGRect(x: 80, y: 240, width: btn_share.bounds.width, height: btn_share.bounds.height)
        view.addSubview(btn_share)
        
        //默认 自定义按钮 返回效果
        let btn1 = UIButton.zjsBackWithTextButton()
        btn1.frame = CGRect(x: 20, y: 280, width: btn1.bounds.width, height: btn1.bounds.height)
        view.addSubview(btn1)
        
        //修改参数 配置样式
        let btn2 = UIButton.zjsBackWithTextButton("返回文字", target: self, action: #selector(backPressed))
        btn2.frame = CGRect(x: 20, y: 320, width: btn2.bounds.width, height: btn2.bounds.height)
        view.addSubview(btn2)
        
        //上面图片下面文字的按钮
        let dic = ["fansupport":"赞" ,"fangroup":"圈子","fanlocation":"位置分布","fantrip":"旅行"]
        var x = 20
        for (key,value) in dic {
            let btn4 = UpImageDownTextButton(imageName: key, title: value )
            btn4.frame = CGRect(x:x, y:360, width: 60, height: 60)
            btn4.addTarget(self, action: #selector(btnPrint), for: .touchUpInside)
            view.addSubview(btn4)
            x += 80
        }
        
        let btn3 = SFFirstTextLastImageButton(imageName: "user_center_edit", title: "用户名")
        btn3.frame = CGRect(x: 20, y: 440, width: 140, height: 40)
        view.addSubview(btn3)
        
    }
    
    @objc private func btnPrint() {
        print("test")
    }
}

