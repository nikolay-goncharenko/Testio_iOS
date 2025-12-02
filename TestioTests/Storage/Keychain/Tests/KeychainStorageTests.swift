//
//  KeychainStorageTests.swift
//  TestioTests
//
//  Created by Nick Goncharenko on 01.12.2025.
//

import XCTest
@testable import Testio

final class KeychainStorageTests: XCTestCase {
    
    private var keychain: KeychainStorage!
    
    override func setUp() {
        super.setUp()
        keychain = KeychainStorage()
        keychain.delete(KeychainConfig.tokenKey)
    }
    
    override func tearDown() {
        keychain.delete(KeychainConfig.tokenKey)
        keychain = nil
        super.tearDown()
    }
    
    func testSaveAndGetToken() {
        
        let token = "test_12345"
        keychain.save(token, key: KeychainConfig.tokenKey)
        
        let storedValue = keychain.get(KeychainConfig.tokenKey)
        XCTAssertNotNil(storedValue)
        XCTAssertEqual(storedValue, token)
    }
    
    func testDeleteToken() {
        
        let token = "abcde"
        keychain.save(token, key: KeychainConfig.tokenKey)
        
        keychain.delete(KeychainConfig.tokenKey)
        
        let storedValue = keychain.get(KeychainConfig.tokenKey)
        XCTAssertNil(storedValue)
    }
}
