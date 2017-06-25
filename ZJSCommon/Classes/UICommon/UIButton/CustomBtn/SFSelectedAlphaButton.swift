//
//  SFAlphaButton.swift
//  StarFans
//
//  Created by JingshunZhang on 2017/6/22.
//  Copyright © 2017年 ZhangJingshun. All rights reserved.
//

import UIKit

/// 点击透明度为60%的按钮
class SFSelectedAlphaButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInit()
    }
    
    private func setupInit(){
        showsTouchWhenHighlighted = false
        addTarget(self, action: #selector(changeStyleButtonTouchDown), for: .touchDown)
        addTarget(self, action: #selector(changeStyleButtonTouchCancel), for: [.touchCancel, .touchUpInside, .touchUpOutside, .touchDragExit])
    }
    
    override var isSelected: Bool {
        didSet{
            let alpha:CGFloat = isSelected ? 0.6 : 1
            titleLabel?.alpha = alpha
            imageView?.alpha = alpha
        }
    }
    
    @objc private func changeStyleButtonTouchDown(button: UIButton) {
        isSelected = true
    }
    
    @objc private func changeStyleButtonTouchCancel(button: UIButton) {
        isSelected = false
    }


}
