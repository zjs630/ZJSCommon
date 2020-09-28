//
//  TSCustomButton.swift
//  tsbbt
//
//  Created by liu on 2020/6/24.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

/// 设置位置和间距
public enum TSPositon {
    case top(_ spcae:CGFloat = 10)
    case left(_ spcae:CGFloat = 10)
    case bottom(_ spcae:CGFloat = 10)
    case right(_ spcae:CGFloat = 10)
}
/// 一个有文字和icon按钮。主要是可以设置文字和icon的位置。不涉及状态修改
class TSCustomButton: UIControl {
    var titleLabel:UILabel!
    var imageView:UIImageView!
    fileprivate var backgroundView:UIView!
    /// 设置title位置、 和图片的间距
    public var titlePostion:TSPositon = .left() {
        didSet{
            reloadViewConstrainrs()
        }
    }
    open var contentEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) {
        didSet {
            backgroundView.snp.updateConstraints { (maker) in
                maker.top.equalTo(contentEdgeInsets.top)
                maker.left.equalTo(contentEdgeInsets.left)
                maker.bottom.equalTo(-contentEdgeInsets.bottom)
                maker.right.equalTo(-contentEdgeInsets.right)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundView = UIView()
        backgroundView.isUserInteractionEnabled = false
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (maker) in
            maker.top.left.equalTo(5)
            maker.bottom.right.equalTo(-5)
            maker.center.equalToSuperview().priority(.low)
        }
        titleLabel = UILabel()
        
        backgroundView.addSubview(titleLabel)
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        backgroundView.addSubview(imageView)
        reloadViewConstrainrs()
        //self.imageView.image = self.imageView.image?.withRenderingMode(.alwaysTemplate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func changeToColor(_ color:UIColor) {
        self.titleLabel.textColor = color
    }
}

extension TSCustomButton {
    fileprivate func reloadViewConstrainrs() {
        switch titlePostion {
        case .top(let space):
            titleLabel.textAlignment = .center
            titleLabel?.snp.remakeConstraints({ (maker) in
                maker.top.left.right.equalToSuperview()
            })
            imageView?.snp.remakeConstraints({ (maker) in
                maker.bottom.left.right.equalToSuperview()
                maker.top.equalTo(titleLabel.snp.bottom).offset(space)
            })
            
        case .left(let space):
            titleLabel?.snp.remakeConstraints { (maker) in
                maker.left.top.bottom.equalToSuperview()
            }
            imageView?.snp.remakeConstraints({ (maker) in
                maker.top.bottom.right.equalToSuperview()
                maker.left.equalTo(titleLabel.snp.right).offset(space)
            })
        case .right(let space):
            titleLabel?.snp.remakeConstraints { (maker) in
                maker.right.top.bottom.equalToSuperview()
            }
            imageView?.snp.remakeConstraints({ (maker) in
                maker.top.bottom.left.equalToSuperview()
                maker.right.equalTo(titleLabel.snp.left).offset(-space)
            })
        case .bottom(let space):
            titleLabel.textAlignment = .center
            titleLabel?.snp.remakeConstraints { (maker) in
                maker.left.greaterThanOrEqualToSuperview()
                maker.right.lessThanOrEqualToSuperview()
                maker.centerX.equalToSuperview()
                maker.bottom.equalToSuperview()
            }
            imageView?.snp.remakeConstraints({ (maker) in
                maker.top.equalToSuperview()
                maker.left.greaterThanOrEqualToSuperview()
                maker.right.lessThanOrEqualToSuperview()
                maker.centerX.equalToSuperview()
                maker.bottom.equalTo(titleLabel.snp.top).offset(-space)
            })
        }
    }
}
