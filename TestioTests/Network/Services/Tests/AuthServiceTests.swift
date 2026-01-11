//
//  AuthServiceTests.swift
//  Testio
//
//  Created by Nick Goncharenko on 01.12.2025.
//

import XCTest
@testable import Testio

final class AuthServiceTests: XCTestCase {
    
    var apiMock: APIClientMock!
    var keychainMock: KeychainStorageMock!
    
    override func setUpWithError() throws {
        apiMock = APIClientMock()
        keychainMock = KeychainStorageMock()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        apiMock = nil
        keychainMock = nil
        try super.tearDownWithError()
    }
    
    func testSignInSuccess() throws {
        let expectedToken = "abc123"
        apiMock.resultToReturn = AuthResponseDTO(token: expectedToken)
        
        let service = AuthService(apiClient: apiMock, keychain: keychainMock)
        
        let dto = AuthRequestDTO(username: "mocked_user", password: "mocked_password")
        
        let expectation = expectation(description: "Sign In Success")
        
        service.signIn(dto: dto) { [weak self] result in
            if let self, case .success(let response) = result {
                XCTAssertEqual(response.token, expectedToken)
                XCTAssertEqual(keychainMock.savedValue, expectedToken)
            } else {
                XCTFail("Expected success result")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(apiMock.didCallRequest)
    }
    
    func testSignInFailure() throws {
        
        apiMock.resultToReturn = nil
        
        let service = AuthService(apiClient: apiMock, keychain: keychainMock)
        
        let dto = AuthRequestDTO(username: "mocked_user", password: "mocked_password")
        
        let expectation = expectation(description: "Sign In Failure")
        
        service.signIn(dto: dto) { [weak self] result in
            guard let self else {
                XCTFail("self is nil")
                expectation.fulfill()
                return
            }
            
            switch result {
            case .success:
                XCTFail("Expected failure, got success")
            case .failure(let error):
                XCTAssertTrue(error is APIClientMock.TestError)
            }
            
            XCTAssertNil(keychainMock.savedValue)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(apiMock.didCallRequest)
    }
}
