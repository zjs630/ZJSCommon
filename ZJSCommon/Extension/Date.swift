//
//  Date.swift
//  tsbbtClient
//
//  Created by zjs on 2020/8/1.
//  Copyright © 2020 ix86. All rights reserved.
//

import Foundation

/// 日期格式化
private let dateFormatter = DateFormatter()
/// 日历
private let calendar = Calendar.current

extension Date {
    /// 将日期字符串转换为日期Date对象
    /// - Parameter string: "2020-08-01 10:58:19"
    /// - Returns: 日期
    static func ts_Date(string: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)
    }
    
    /// 将日期字符串转换为日期Date对象
    /// - Parameter string:  "2020-08-01"
    static func ts_Date2(string: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }

    /// 获取今天的日期字符串
    /// - Returns: 返回日期字符串 如：2010-08-01
    static func ts_todayString() -> String {
        let date = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd" // 日期格式
        return dateFormatter.string(from: date)
    }
    /// 获取今天的日期字符串
    /// - Returns: 返回日期字符串 如：2010-08
    static func ts_todayYMString() -> String {
       let date = Date()
        dateFormatter.dateFormat = "yyyy-MM" // 日期格式
        return dateFormatter.string(from: date)
    }
    
    /// 返回日期字符串 如：2010-08-01
    func toDateString() -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    /**
     1、当天时间显示：时，分｜ HH:mm(今天)
     2、当年非当天显示：月，日，时，分｜ MM-dd HH:mm(今年)
     3、非当年显示：年，月，日，时，分｜ yyyy-MM-dd HH:mm(更早期)
     */
    /// 将日期Date对象转换为字符串
    var ts_dateDescription: String {
        var fmt = ""
        // 1. 判断日期是否是今天
        if calendar.isDateInToday(self) {
            fmt = "HH:mm"
        } else {
            let year = calendar.component(.year, from: self)
            let thisYear = calendar.component(.year, from: Date())
            
            if year != thisYear { // 3. 非当年显示
                fmt = "yyyy-MM-dd HH:mm"
            } else { // 2. 当年非当天
                fmt = "MM-dd HH:mm"
            }
        }
        // 设置日期格式字符串
        dateFormatter.dateFormat = fmt
        
        return dateFormatter.string(from: self)
    }
    func toString(format:String = "yyyy-MM-dd HH:mm:ss") -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    /// 如果是今年，则返回：xx月xx日 。如果以前年，则xxxx年xx月xx日
    func toDescription() -> String {
        var fmt = ""
        let year = calendar.component(.year, from: self)
        let thisYear = calendar.component(.year, from: Date())
        
        if year != thisYear { // 3. 非当年显示
            fmt = "yyyy年MM月dd日"
        } else { // 2. 当年非当天
            fmt = "MM月dd日"
        }
        // 设置日期格式字符串
        dateFormatter.dateFormat = fmt
        
        return dateFormatter.string(from: self)
    }
}
extension String {
    func toDate(format:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: self)
        return date
    }
}
