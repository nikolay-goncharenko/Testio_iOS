//
//  ServerListServiceTests.swift
//  Testio
//
//  Created by Nick Goncharenko on 01.12.2025.
//

import XCTest
@testable import Testio

final class ServerListServiceTests: XCTestCase {
    
    var apiMock: APIClientMock!
    var keychainMock: KeychainStorageMock!
    var service: ServerListService!
    
    override func setUpWithError() throws {
        apiMock = APIClientMock()
        keychainMock = KeychainStorageMock()
        service = ServerListService(apiClient: apiMock, keychain: keychainMock)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        apiMock = nil
        keychainMock = nil
        service = nil
        try super.tearDownWithError()
    }
    
    func testFetchServerListSuccess() throws {
        
        let expectedServers = [
            ServerListResponseDTO(name: "alpha", distance: 10),
            ServerListResponseDTO(name: "beta", distance: 20)
        ]
        
        apiMock.resultToReturn = expectedServers
        if let savedValue = keychainMock.savedValue {
            keychainMock.save("mocked_token", key: savedValue)
        }
        
        let expectation = expectation(description: "FetchServerListSuccess")
        
        service.fetchServerList { result in
            switch result {
            case .success(let list):
                XCTAssertEqual(list.count, 2)
                XCTAssertEqual(list[0].name, "alpha")
                XCTAssertEqual(list[1].distance, 20)
                
            case .failure:
                XCTFail("Expected success but got failure")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(apiMock.didCallRequest)
    }
    
    func testFetchServerListFailure() throws {
        
        apiMock.resultToReturn = nil
        
        let expectation = expectation(description: "FetchServerListFailure")
        
        service.fetchServerList { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
                
            case .failure(let error):
                XCTAssertTrue(error is APIClientMock.TestError)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(apiMock.didCallRequest)
    }
}
