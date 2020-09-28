//
//  MySQLLiteManager.swift
//  WordToPinYinProject
//
//  Created by ZhangJingshun on 2020/8/12.
//  Copyright © 2020 zjs. All rights reserved.
//

import Foundation
import FMDB

class MySQLLiteManager {
    
    static let shared = MySQLLiteManager()
    /// 数据库队列
    let queue: FMDatabaseQueue
    
    private init() {
        let path = Bundle.main.path(forResource: "china_cities_v2", ofType: "db")
        print(path ?? "")
        queue = FMDatabaseQueue(path: path)!
    }
    
}

//MARK: - 城市列表及搜索接口
extension MySQLLiteManager {
    /// 获取索引字母
    func getAllGroupWord() -> [String] {
        var result: [String] = []
        let sql = "select c_pinyin from ordered_cities group by c_pinyin"
        queue.inDatabase { (db) in
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            while rs.next() {
                if let value = rs.object(forColumnIndex: 0) {
                    result.append(value as? String ?? "")
                }
            }
        }
        // print(result)
        return result
    }
    
    /// 获取所有城市首字母对应的城市数组
    /// - Parameter groupWord: 城市首字母
    func getAllGroupedCitys(with groupWord: [String]) -> [[[String:String]]] {
        var resultList = [[[String:String]]]()
        for value in groupWord {
            let sql = "select c_fullname, c_code from ordered_cities where c_pinyin = \'\(value)\'"
            let result = execRecordSet(sql: sql)
            resultList.append(result)
        }
        return resultList
    }
    /// 搜索城市名字接口
    func searchCity(with name: String) -> [[String: String]] {
        let sql = "select c_fullname, c_code from ordered_cities where c_name like \'%\(name)%\'"
        let result = execRecordSet(sql: sql)
        return result
    }
    
    func execRecordSet(sql: String) -> [[String: String]] {
        var result = [[String: String]]()
        queue.inDatabase { (db) in
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            var lineDic:[String: String] = [:]
            while rs.next() {
                let colCount = rs.columnCount
                for col in 0..<colCount {
                    guard let name = rs.columnName(for: col),
                        let value = rs.object(forColumnIndex: col) else {
                            continue
                    }
                    lineDic[name] = value as? String
                }
                result.append(lineDic)
            }
        }
        return result
    }
        
}


//MARK: - 判断是否同一个城市的接口
extension MySQLLiteManager {
    
    /// 获取城市码
    /// - Parameter name: 定位的城市名
    func getCityCode(with name: String) -> String {
        let sql = "select c_code from ordered_cities where c_name = \'\(name)\'"
        var cityCode = ""
        queue.inDatabase { (db) in
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            while rs.next() {
                if let code =  rs.object(forColumnIndex: 0) as? String {
                    cityCode = code
                }
            }
        }
        return cityCode
    }
    /// 获取区县或城市的Province码
    /// - Parameter name: 选择的城市名
    func getProvinceCode(with code: String) -> String {
        let sql = "select c_province from ordered_cities where c_code = \'\(code)\'"
        var provinceCode = ""
        queue.inDatabase { (db) in
            guard let rs = db.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            while rs.next() {
                if let code =  rs.object(forColumnIndex: 0) as? String {
                    provinceCode = code
                }
            }
        }
        return provinceCode
    }
}

