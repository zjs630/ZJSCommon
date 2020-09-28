//
//  UIScreen.swift
//  tsbbtClient
//
//  Created by zjs on 2020/7/25.
//  Copyright © 2020 ix86. All rights reserved.
//

import UIKit


extension UIScreen {
    
    /// 屏幕宽度
    static let width: CGFloat = UIScreen.main.bounds.width
    
    /// 屏幕高度
    static let height: CGFloat = UIScreen.main.bounds.height
        
    /// 是否是全面屏
    /// iPhone X，XS，11，11 Pro高度为812，
    /// iPhone XS Max，XR，11 Pro max高度为896
    static var isFullScreen: Bool {
        let h = UIScreen.height
        return  h == 812 || h == 896
    }
    
    /// 距离顶部的安全高度 //状态栏高度+导航栏高度
    static var topSafeHight: CGFloat {
        return statusBarHight + navigationBarHight
    }
    /// 底部的安全高度 //无tabBar的情况
    static var bottomSafeHight: CGFloat {
        return isFullScreen ? 34.0 : 0
    }

    /// 状态栏高度
    static var statusBarHight: CGFloat {
        return isFullScreen ? 44.0 : 20.0
    }
    /// 导航栏高度
    static var navigationBarHight: CGFloat {
        return 44.0
    }
    /// tabBar高度（包含底部安全区域的高度）
    static var tabBarSafeHight: CGFloat {
        return isFullScreen ? (49.0+34.0) : 49.0
    }
    
}
