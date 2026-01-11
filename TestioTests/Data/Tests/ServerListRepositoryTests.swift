//
//  ServerListRepositoryTests.swift
//  Testio
//
//  Created by Nick Goncharenko on 02.12.2025.
//

import XCTest
@testable import Testio

final class ServerListRepositoryTests: XCTestCase {
    
    var serviceMock: ServerListServiceMock!
    var storageMock: ServerListStorageMock!
    var repository: ServerListRepository!
    
    override func setUpWithError() throws {
        serviceMock = ServerListServiceMock()
        storageMock = ServerListStorageMock()
        repository = ServerListRepository(service: serviceMock, storage: storageMock)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        serviceMock = nil
        storageMock = nil
        repository = nil
        try super.tearDownWithError()
    }
    
    func serverListDTO(name: String, distance: Int) -> ServerListResponseDTO {
        ServerListResponseDTO(name: name, distance: distance)
    }
    
    func serverListObject(name: String, distance: Int, originalOrder: Int) -> ServerListObject {
        let object = ServerListObject()
        object.name = name
        object.distance = distance
        object.originalOrder = originalOrder
        return object
    }
    
    func testFetchServerListSuccess() {
        let dtos = [
            serverListDTO(name: "b", distance: 2),
            serverListDTO(name: "a", distance: 1)
        ]
        serviceMock.resultToReturn = .success(dtos)
        storageMock.fetched = dtos.enumerated().map { index, dto in
            serverListObject(name: dto.name, distance: dto.distance, originalOrder: index)
        }
        
        let expectation = expectation(description: "Fetch success")
        
        repository.getSortedServerList(by: .originalOrder) { [weak self] list in
            if let self {
                XCTAssertEqual(list.count, 2)
                XCTAssertEqual(list[0].originalOrder, 0)
                XCTAssertEqual(list[1].originalOrder, 1)
                XCTAssertTrue(serviceMock.didCallFetch)
                XCTAssertEqual(storageMock.saved, dtos)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchServerListFailureReturnsCached() {
        serviceMock.resultToReturn = .failure(ServerListServiceMock.TestError.fetchError)
        let cached = [
            serverListObject(name: "cached1", distance: 5, originalOrder: 0)
        ]
        storageMock.fetched = cached
        
        let expectation = expectation(description: "Fetch failure uses cache")
        
        repository.getSortedServerList(by: .originalOrder) { list in
            XCTAssertEqual(list, cached)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSortingDistance() {
        let dtos = [
            serverListDTO(name: "a", distance: 5),
            serverListDTO(name: "b", distance: 2)
        ]
        serviceMock.resultToReturn = .success(dtos)
        storageMock.fetched = dtos.enumerated().map { index, dto in
            serverListObject(name: dto.name, distance: dto.distance, originalOrder: index)
        }
        
        let expectation = expectation(description: "Sort by distance")
        
        repository.getSortedServerList(by: .distance) { list in
            XCTAssertEqual(list[0].distance, 2)
            XCTAssertEqual(list[1].distance, 5)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSortingName() {
        let dtos = [
            serverListDTO(name: "b", distance: 5),
            serverListDTO(name: "a", distance: 2)
        ]
        serviceMock.resultToReturn = .success(dtos)
        storageMock.fetched = dtos.enumerated().map { index, dto in
            serverListObject(name: dto.name, distance: dto.distance, originalOrder: index)
        }
        
        let expectation = expectation(description: "Sort by name")
        
        repository.getSortedServerList(by: .name) { list in
            XCTAssertEqual(list[0].name, "a")
            XCTAssertEqual(list[1].name, "b")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testClearCache() {
        storageMock.saved = [
            serverListDTO(name: "x", distance: 1)
        ]
        
        repository.clearCache()
        
        XCTAssertTrue(storageMock.saved.isEmpty)
    }
}
