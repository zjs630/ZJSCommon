//
//  MyBaseView.swift
//  tsbbtClient
//
//  Created by zjs on 2020/7/27.
//  Copyright © 2020 tawy. All rights reserved.
//

import UIKit

class MyBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyBaseView {
    @objc  func setupUI() {}
}
