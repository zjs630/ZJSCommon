//
//  RotaionViewController.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2017/2/13.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit

class RotaionViewController: UIViewController {
    var imgView: SLAnimationImageView?
    
    var loadingView: SLLoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        self.addAnimationView()
        imgView?.startAnimating()
        
        self.addLoadingView()//自动开启动画，需要停止，可隐藏视图， // loadingView.hidden = YES;
        
        self.loadData()
        
    }    

    func addLoadingView() {
        loadingView = SLLoadingView()
        view.addSubview(loadingView!)
    }

    func addAnimationView() {
        imgView = SLAnimationImageView()
        imgView?.image = UIImage(named: "icon_loading")
        imgView?.frame = CGRect(x: 20, y: 84, width: (imgView?.bounds.width)!, height: (imgView?.bounds.height)!)
        view.addSubview(imgView!)
    }
    
    private func loadData(){
        //模拟加载数据
        //......
        //三秒后停止动画
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            self.imgView?.stopAnimating()
//                    self.loadingView?.setNeedsUpdateConstraints()
//                    self.loadingView?.updateConstraints()

        }
    }
    
}
