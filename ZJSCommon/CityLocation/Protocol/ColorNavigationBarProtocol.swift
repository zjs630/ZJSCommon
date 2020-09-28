//
//  ColorNavigationBarProtocol.swift
//  tsbbtClient
//
//  Created by ZhangJingshun on 2020/8/12.
//  Copyright © 2020 tawy. All rights reserved.
//

import Foundation

/// 设置带搜索框的返回导航条
@objc protocol BackSearchNavigationBarProtocol: NSObjectProtocol {
    /// 搜索栏的代理
    var searchDelegate: UITextFieldDelegate {get}
    @objc func textFieldTextDidChange(notify: Notification)
}
extension BackSearchNavigationBarProtocol where Self: UIViewController {
    /// 添加带搜索的导航栏
    func addNavigationBar() {
        let naviBarView = BackSearchNavigationBarView()
        view.addSubview(naviBarView)
        naviBarView.snp.makeConstraints { (m) in
            m.top.left.right.equalTo(0)
            m.height.equalTo(UIScreen.topSafeHight)
        }
        naviBarView.searchBar.delegate = searchDelegate
        NotificationCenter.default.addObserver(searchDelegate, selector: #selector(textFieldTextDidChange(notify:)), name: UITextField.textDidChangeNotification, object: naviBarView.searchBar)

    }
}

/// 设置带渐变颜色的返回导航条
protocol BackColorNavigationBarProtocol {}
extension BackColorNavigationBarProtocol where Self: UIViewController {
    /// 添加带渐变色的导航栏
    func addNavigationBar() {
        let naviBarView = BaseColorNavigationBarView()
        view.addSubview(naviBarView)
        naviBarView.snp.makeConstraints { (m) in
            m.top.left.right.equalTo(0)
            m.height.equalTo(UIScreen.topSafeHight)
        }
    }
}
