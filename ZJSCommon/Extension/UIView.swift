//
//  View.swift
//  tsbbt
//
//  Created by zjs on 2020/6/16.
//  Copyright © 2020 ix86. All rights reserved.
//

import UIKit


extension UIView {
    
    /// 自定义颜色的UIView
    /// - Parameter color: 16进制颜色
    /// - Parameter corner: 圆角大小
    /// - Returns: UIView
    static func ts_colorView(color: UInt32, corner: CGFloat = 0) -> UIView {
        let view = UIView()
        if corner > 0 {
            view.layer.cornerRadius = corner
            view.layer.masksToBounds = true
        }
        view.backgroundColor = UIColor(color)
        return view
    }
    
    /// 圆角带边框的View
    /// - Parameters:
    ///   - color: 边框颜色（十六进制）
    ///   - width: 边框宽度
    ///   - corner: 圆角大小
    ///   - bgColor: view背景颜色
    static func ts_borderView(color: UInt32, width: CGFloat = 1/UIScreen.main.scale, corner: CGFloat = 0,bgColor: UInt32 = 0xFFFFFF) -> UIView {
        let view = UIView()
        if corner > 0 {
            view.layer.cornerRadius = corner
            view.layer.masksToBounds = true
        }
        view.layer.borderColor = UIColor(color).cgColor
        view.layer.borderWidth = width
        view.backgroundColor = UIColor(bgColor)
        return view
    }

    
    /// 截取View的屏幕
    public func takeCurrentShot() -> UIImage? {
           UIGraphicsBeginImageContextWithOptions(bounds.size, true, UIScreen.main.scale)
           let context = UIGraphicsGetCurrentContext()
           layer.render(in: context!)
           let img = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return img
    }
    
    /// 设置部分圆角
      ///
      /// - Parameters:
      ///   - roundingCorners: 哪几种圆角 [.bottomLeft, .bottomRight]
      ///   - cornerSize: 圆角尺寸
      func setMaskCorner(roundingCorners: UIRectCorner, cornerSize: CGSize) {
          let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerSize.width, height: cornerSize.height))
          let maskLayer = CAShapeLayer()
          maskLayer.frame = self.bounds
          maskLayer.path = maskPath.cgPath
          self.layer.mask = maskLayer
      }
    
    
}


extension UIView {
    /// x
     public var x: CGFloat {
         get {
             return frame.origin.x
         }
         set(newValue) {
             var tempFrame: CGRect = frame
             tempFrame.origin.x = newValue
             frame = tempFrame
         }
     }

     /// y
     public var y: CGFloat {
         get {
             return frame.origin.y
         }
         set(newValue) {
             var tempFrame: CGRect = frame
             tempFrame.origin.y = newValue
             frame = tempFrame
         }
     }

     /// height
     public var height: CGFloat {
         get {
             return frame.size.height
         }
         set(newValue) {
             var tempFrame: CGRect = frame
             tempFrame.size.height = newValue
             frame = tempFrame
         }
     }

     /// width
     public var width: CGFloat {
         get {
             return frame.size.width
         }
         set(newValue) {
             var tempFrame: CGRect = frame
             tempFrame.size.width = newValue
             frame = tempFrame
         }
     }
}

extension UIView {
    var getCurrentVC: UIViewController? {
        var next = superview
        while next != nil {
            let nextResponder = next?.next
            if nextResponder is UIViewController {
                return nextResponder as? UIViewController
            }
            next = next?.superview
        }
        return nil
    }
}

