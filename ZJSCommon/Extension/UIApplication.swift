//
//  Application.swift
//  tsbbt
//
//  Created by liu on 2020/6/16.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

extension UIApplication {
    public static var keyWindow :UIWindow? {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)?.window
        }
    }
    open var currentNavigationController:UINavigationController? {
        var parent: UIViewController?
        if let window = UIApplication.shared.delegate?.window,let rootVC = window?.rootViewController {
            parent = rootVC
            while (parent?.presentedViewController != nil) {
                parent = parent?.presentedViewController!
            }
            if let tabbar = parent as? UITabBarController ,let nav = tabbar.selectedViewController as? UINavigationController {
                return nav
            }else if let nav = parent as? UINavigationController {
                return nav
            }
        }
        return nil
    }
    public var rootViewController:UIViewController? {
        if let window = UIApplication.shared.delegate?.window,let rootVC = window?.rootViewController {
            return rootVC
        }
        return nil
    }
    public func presentTo(_ controller:UIViewController) {
        controller.modalPresentationStyle = .overFullScreen
        currentNavigationController?.present(controller, animated: true, completion: nil)
    }
    public func pushTo(_ controller:UIViewController) {
        controller.hidesBottomBarWhenPushed = true
        currentNavigationController?.pushViewController(controller, animated: true)
    }
    
    /// 打开系统设置页面
    @objc static func ts_openSystemSettingPage() {
        let settingsUrl = URL(string:UIApplication.openSettingsURLString)!
        if UIApplication.shared.canOpenURL(settingsUrl){
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    /// 拨打电话
    /// - Parameter number: 电话号码
    public static func ts_callUserPhone(number: String) {
        if let url = URL(string: "telprompt://\(number)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    public var topViewController:UIViewController? {
        var parent: UIViewController?
        if let window = UIApplication.shared.delegate?.window,let rootVC = window?.rootViewController {
            parent = rootVC
            while (parent?.presentedViewController != nil) {
                parent = parent?.presentedViewController!
            }
            if let tabbar = parent as? UITabBarController {
                if let nav = tabbar.selectedViewController as? UINavigationController {
                    parent = nav.topViewController
                }else if let vc = tabbar.selectedViewController {
                    parent = vc
                }
            }else if let nav = parent as? UINavigationController {
                parent = nav.topViewController
            }
            if parent != nil {
                return parent!
            }
        }
        return nil
    }
    
}

