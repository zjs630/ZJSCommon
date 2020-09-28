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
    
    
    @IBAction func showRotationViewController(_ sender: UIButton) {
        let vc = RotaionViewController()
        navigationController?.pushViewController(vc, animated: true)

        
    }
    @IBAction func showBackViewController(_ sender: UIButton) {
        let vc = BackButtonViewController()
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIButton.zjsBackWithTextButton("zjs", target: self, action: #selector(backPressed)))
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc fileprivate func backPressed(){
        _ = navigationController?.popViewController(animated: true)
    }

    @IBAction func httpHeaderPressed(_ sender: UIButton) {
        print(HttpHeader.headers)
        
    }
    
    @IBAction func showSegmentViewController(_ sender: UIButton) {
        navigationController?.pushViewController(SegmentViewController(),animated: true)
    }
    
    
    @IBAction func cityLocation(_ sender: UIButton) {
        navigationController?.pushViewController(HomeViewController(),animated: true)
    }
    
}

