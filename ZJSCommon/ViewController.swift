//
//  ViewController.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2017/1/18.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showBackViewController(_ sender: UIButton) {
        let vc = BackButtonViewController()
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.zjsBackButton("zjs", target: self, action: #selector(backPressed)))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc fileprivate func backPressed(){
        _ = navigationController?.popViewController(animated: true)
    }

}

