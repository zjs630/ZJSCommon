//
//  KeyChainManager.swift
//  KeyChainTest
//
//  Created by ZhangJingshun on 2018/4/9.
//  Copyright © 2018年 YHCS. All rights reserved.
//

import Security
import Foundation

/// 主要用于存储uuid，避免删除app，导致uuid重置引起的问题
class KeyChainManager {
    static let server = "com.yhcs.app"
    var deviceToken = ""
    var key = ""
    
    subscript(string key: String) -> String? {
        get {
            // 通过key，查找token
            let token = searchItem(key: key)
            return token
        }
        set {
            if let value = newValue {
                self.key = key
                self.deviceToken = value
                //存储token
                _ = addItem()
            }
        }
    }
    
    //添加到keychain中，已经添加的，就不会再添加了。
    func addItem() -> Bool {
        let uuid = deviceToken.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: key,
                                    kSecAttrServer as String: KeyChainManager.server,
                                    kSecValueData as String: uuid]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            return true
        }
        return false
    }
    
    /// 依据key查找value
    func searchItem(key: String) -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: KeyChainManager.server,
                                    kSecMatchLimit as String: kSecMatchLimitAll,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        
        var items: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &items)
        guard status != errSecItemNotFound else { // 没有找到
            return nil
        }
        guard status == errSecSuccess else { //其它错误
            return nil
        }
        if let items = items as? [[String : Any]] {
            for existingItem in items {
                guard let passwordData = existingItem[kSecValueData as String] as? Data,
                    let account = existingItem[kSecAttrAccount as String] as? String,
                    let password = String(data: passwordData, encoding: String.Encoding.utf8),
                    account == key else {
                        continue
                }
                return password
            }
        }
        return nil
    }
    
    /// 删除所有的keychain
    func deleteItem() -> Bool {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: KeyChainManager.server]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            return false
        }
        return true
    }
}
