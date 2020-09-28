//
//  SearchTextField.swift
//  tsbbtClient
//
//  Created by zjs on 2020/7/23.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit


class SearchTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    var placeholderText: String = ""
    
    convenience init(placeholder text: String) {
        self.init(frame: .zero)
        placeholder = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        
        let fontColor = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12),
                         NSAttributedString.Key.foregroundColor: UIColor(0xCACACA)]
        let aString = NSAttributedString(string: "搜索商家/商品等", attributes: fontColor)
        attributedPlaceholder = aString
        
        background = nil
        tintColor = UIColor(0xFFBA00)
        font = UIFont.systemFont(ofSize: 12)
        backgroundColor = UIColor(0xFFFFFF)
        layer.cornerRadius = 30 / 2
        clipsToBounds = true
        returnKeyType = .search
        enablesReturnKeyAutomatically = true
        clearButtonMode = .whileEditing// 系统自带关闭按钮
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18 + 13 + 3, height: 30))
        let iv = UIImageView(image: UIImage(named: "home_searchbar_search"))
        iv.contentMode = .center
        iv.frame = CGRect(x: 13, y: 8, width: 18, height: 15)
        paddingView.addSubview(iv)
        leftView = paddingView
        leftViewMode = .always
        
//        let rightImageView = UIImageView(image: UIImage(named: "btn_close_white"))
//        rightImageView.contentMode = .center
//        rightView = rightImageView
//        rightViewMode = .always
        
    }
}

