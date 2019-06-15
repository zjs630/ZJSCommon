//
//  Date+Extension.swift
//  ZJSCommon
//
//  Created by ZhangJingshun on 2019/6/15.
//  Copyright © 2019 ix86. All rights reserved.
//

import Foundation

private let dateFormatter = DateFormatter()

// MARK: - 日期转换
extension Date {
    /// 计算日期字符串
    ///
    /// - Parameter timeStamp: 1970年开始的时间戳,单位毫秒
    /// - Returns: 返回 “2019年5月19日” 这种格式的日期字符串
    /// 计算日期字符串
    ///
    /// - Parameters:
    ///   - timeStamp: 1970年开始的时间戳,单位毫秒
    ///   - format: 时间格式 如："yyyy-MM-dd"，"yyyy年MM月dd日"
    /// - Returns: 默认返回 “2019年5月19日” 这种格式的日期字符串
    static func js_dateString(timeStamp: TimeInterval, format: String = "yyyy年M月d日") -> String {
        let date = Date(timeIntervalSince1970: timeStamp / 1000)
        dateFormatter.dateFormat = format // 日期格式
        return dateFormatter.string(from: date)
    }
    
    
    /// 计算日期字符串
    ///
    /// - Parameter timeStamp: 1970年开始的时间戳,单位秒
    /// - Returns: 返回 “2019-05-19 15:16” 这种格式的日期字符串
    static func js_detailDateString(timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // 日期格式
        return dateFormatter.string(from: date)
    }

}
