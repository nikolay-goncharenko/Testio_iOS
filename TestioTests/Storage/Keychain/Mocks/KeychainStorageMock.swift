//
//  KeychainStorageMock.swift
//  Testio
//
//  Created by Nick Goncharenko on 01.12.2025.
//

@testable import Testio

final class KeychainStorageMock: KeychainStorageProtocol {
    
    var savedValue: String?
    
    func save(_ value: String, key: String) {
        savedValue = value
    }
    
    func get(_ key: String) -> String? {
        savedValue
    }
    
    func delete(_ key: String) {
        savedValue = nil
    }
}
