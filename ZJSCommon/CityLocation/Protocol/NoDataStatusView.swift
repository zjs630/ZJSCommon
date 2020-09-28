//
//  NoDataStatusView.swift
//  tsbbtClient
//
//  Created by zjs on 2020/7/31.
//  Copyright © 2020 tawy. All rights reserved.
//

import Foundation

/// Controller无数据状态的View
@objc protocol NoDataStatusView {
    /// controller内部自己控制是否hidden
    var noDataView: UIView { get set }
    ///  未开启定位权限时，显示开启定位权限View
    @objc optional var noLocationView: UIView { get set }
}

extension NoDataStatusView where Self: UIViewController {
    /// 配置图片和文字，目前用于我的收藏，消息列表，免费领取帮帮券等页面无数据时UI展示
    /// - Parameters:
    ///   - url: 图片名
    ///   - text: 文本
    func showNoDataView(image name:String,text: String) {
        // 避免重复添加
        if noDataView.superview != nil {
            return
        }
        
        noDataView.backgroundColor = UIColor.clear
        noDataView.isUserInteractionEnabled = false
        let imgView = UIImageView(image: UIImage(named: name))
        noDataView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(0)
        }
        
        let label = UILabel.ts_label(text: text, font: 15, color: UIColor(0x94989F))
        label.numberOfLines = 2
        label.textAlignment = .center
        noDataView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(180 * UIScreen.width / 375.0)
            make.bottom.equalTo(0)
        }
        view.addSubview(noDataView)
        noDataView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.width.equalTo(UIScreen.width).priority(.low)
            make.top.equalTo(155+UIScreen.topSafeHight)
        }
    }
    
    /// 无定位权限时的定制UI,依赖noDataView
    func showNoLocationView(){

        showNoDataView(image: "location_no_authorization", text: "未开启定位权限，请开启权限后查看更多帮帮券")
        if let label = noDataView.subviews.filter({ $0 is UILabel }).last {
            label.snp.updateConstraints { (m) in
                m.bottom.equalTo(-46)
            }
        }

        noDataView.addSubview(noLocationView!)
        noLocationView?.snp.makeConstraints{ (m) in
            m.bottom.left.right.equalTo(0)
            m.height.equalTo(46)
        }
        
        let attributes:[NSAttributedString.Key: Any] = [.foregroundColor: UIColor(0xFFBA00), .font: UIFont.systemFont(ofSize: 15), .underlineStyle: NSUnderlineStyle.single.rawValue]
        let aText = NSAttributedString(string: "开启定位权限",attributes:attributes)

        let btn = UIButton()
        btn.addTarget(UIApplication.self, action: #selector(UIApplication.ts_openSystemSettingPage), for: .touchUpInside)
        btn.setAttributedTitle(aText, for: .normal)
        noLocationView?.addSubview(btn)
        btn.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.bottom.equalTo(0)
        }
        noDataView.isUserInteractionEnabled = true

    }
    
}
