//
//  HomeViewController.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2020/9/28.
//  Copyright © 2020 ix86. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let navigationBarView = HomeNavigationBarView()
    private let manager = LocationManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        setupNavi()

    }
    
    private func startLocation() {
        navigationBarView.setCity(text: "定位中…")
        manager.delegate = self
        manager.startLocation()
    }
    /// 设置导航栏 注意高度包含状态栏
    private func setupNavi() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(naviLeftClicked))
        navigationBarView.locationImageView.addGestureRecognizer(tap)
        navigationBarView.cityBtn.addTarget(self, action: #selector(naviLeftClicked), for: .touchUpInside)
        view.addSubview(navigationBarView)
        navigationBarView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(UIScreen.topSafeHight)
        }
    }
    
    @objc fileprivate func naviLeftClicked() {
        navigationController?.pushViewController(HomeChangeCityController(), animated: true)
    }

}

// MARK: - 定位
extension HomeViewController: LocationManagerDelegate {
    func userSelectedOrLocatedPosition(city: String) {
        navigationBarView.setCity(text: city)
        //切换城市后，刷新店铺列表数据
        print("----userSelectedOrLocatedPosition---")
        //refreshData()
    }
}
