//
//  HttpHeader.swift
//  YHCSFINANCE
//
//  Created by ZhangJingshun on 2018/4/9.
//  Copyright © 2018年 YHCS. All rights reserved.
//

import Foundation

// 封装http请求的header信息
struct HttpHeader {
    
    static var headers:[String: String] = {
        var headers = [String: String]()
        headers["Platform"] = "IOS"
        headers["Sys-Version"] = UIDevice.current.systemVersion
        let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        headers["App-Version"] = ver ?? "0"
        headers["Device-ID"] = UIDevice.deviceId()
        headers["Brand"] = "apple"
        headers["Model"] = UIDevice.modelName
        //print(headers)
        return headers
    }()
}
