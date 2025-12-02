//
//  ServerListServiceMock.swift
//  Testio
//
//  Created by Nick Goncharenko on 01.12.2025.
//

import Foundation
@testable import Testio

final class ServerListServiceMock: ServerListServiceProtocol {
    
    enum TestError: Error { case fetchError }
    
    var resultToReturn: Result<[ServerListResponseDTO], Error>?
    var didCallFetch = false
    
    func fetchServerList(completion: @escaping (Result<[ServerListResponseDTO], Error>) -> Void) {
        didCallFetch = true
        if let result = resultToReturn {
            completion(result)
        } else {
            completion(.failure(TestError.fetchError))
        }
    }
}
