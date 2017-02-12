//
//  BackButtonViewController.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2017/1/18.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//


// MARK: - 查看返回按钮样式的类

import UIKit

class BackButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        //默认 自定义按钮 返回效果
        let btn1 = UIButton.zjsBackButton()
        btn1.center = view.center
        view.addSubview(btn1)
        
        //修改参数 配置样式
        let btn = UIButton.zjsBackButton("返回文字", target: self, action: #selector(backPressed))
        btn.frame = CGRect(x: 20, y: 300, width: btn.bounds.size.width, height: btn.bounds.size.height)
        view.addSubview(btn)

    }


    @objc fileprivate func backPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
}
