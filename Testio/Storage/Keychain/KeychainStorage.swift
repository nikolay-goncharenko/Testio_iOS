//
//  KeychainStorage.swift
//  Testio
//
//  Created by Nick Goncharenko on 29.11.2025.
//

import Foundation
import Security

final class KeychainStorage {
    
    internal func save(_ value: String, key: String) {
        let data = value.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    internal func get(_ key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &item)
        
        if let data = item as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    internal func delete(_ key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
