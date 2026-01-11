//
//  ServerListViewModelTests.swift
//  Testio
//
//  Created by Nick Goncharenko on 02.12.2025.
//

import XCTest
@testable import Testio

final class ServerListViewModelTests: XCTestCase {
    
    var repositoryMock: ServerListRepositoryMock!
    var keychainMock: KeychainStorageMock!
    var viewModel: ServerListViewModel!
    
    override func setUpWithError() throws {
        repositoryMock = ServerListRepositoryMock()
        keychainMock = KeychainStorageMock()
        viewModel = ServerListViewModel(repository: repositoryMock, keychain: keychainMock)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        repositoryMock = nil
        keychainMock = nil
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func serverListObject(name: String, distance: Int, originalOrder: Int) -> ServerListObject {
        let object = ServerListObject()
        object.name = name
        object.distance = distance
        object.originalOrder = originalOrder
        return object
    }
    
    func testFetchServerListOriginalOrder() {
        let expected = [
            serverListObject(name: "b", distance: 2, originalOrder: 1),
            serverListObject(name: "a", distance: 1, originalOrder: 0)
        ]
        repositoryMock.listToReturn = expected
        
        let expectation = expectation(description: "onFetched called")
        
        viewModel.onFetched = { list in
            XCTAssertEqual(list, expected)
            XCTAssertEqual(self.repositoryMock.lastSort, .originalOrder)
            expectation.fulfill()
        }
        
        viewModel.fetchServerList()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchServersSortedByDistance() {
        let expected = [
            serverListObject(name: "b", distance: 2, originalOrder: 1),
            serverListObject(name: "a", distance: 1, originalOrder: 0)
        ]
        repositoryMock.listToReturn = expected
        
        let expectation = expectation(description: "onFetched distance")
        
        viewModel.onFetched = { list in
            XCTAssertEqual(list, expected)
            XCTAssertEqual(self.repositoryMock.lastSort, .distance)
            expectation.fulfill()
        }
        
        viewModel.fetchServersSortedByDistance()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchServersSortedByName() {
        let expected = [
            serverListObject(name: "b", distance: 2, originalOrder: 1),
            serverListObject(name: "a", distance: 1, originalOrder: 0)
        ]
        repositoryMock.listToReturn = expected
        
        let expectation = expectation(description: "onFetched name")
        
        viewModel.onFetched = { list in
            XCTAssertEqual(list, expected)
            XCTAssertEqual(self.repositoryMock.lastSort, .name)
            expectation.fulfill()
        }
        
        viewModel.fetchServersSortedByName()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testClearAuthToken() {
        keychainMock.save("token", key: "mock_key")
        
        XCTAssertNotNil(keychainMock.savedValue)
        
        viewModel.clearAuthToken()
        
        XCTAssertNil(keychainMock.savedValue)
    }
}
