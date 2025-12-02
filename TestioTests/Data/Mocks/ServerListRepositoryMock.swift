//
//  ServerListRepositoryMock.swift
//  Testio
//
//  Created by Nick Goncharenko on 02.12.2025.
//

@testable import Testio

final class ServerListRepositoryMock: ServerListRepositoryProtocol {
    
    var lastSort: ServerListRepository.ServerListSort?
    var listToReturn: [ServerListObject] = []
    var clearCacheCalled = false
    
    func getSortedServerList(
        by sort: ServerListRepository.ServerListSort,
        completion: @escaping ([ServerListObject]) -> Void
    ) {
        lastSort = sort
        completion(listToReturn)
    }
    
    func clearCache() {
        clearCacheCalled = true
    }
}
