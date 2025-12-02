//
//  APIClientMock.swift
//  Testio
//
//  Created by Nick Goncharenko on 01.12.2025.
//

import Alamofire
@testable import Testio

final class APIClientMock: APIClientProtocol {
    
    enum TestError: Error {
        case getError
        case postError
    }
    
    var didCallRequest = false
    var resultToReturn: Any?
    
    func get<T>(_ url: String, method: HTTPMethod, headers: HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        
        didCallRequest = true
        
        if let result = resultToReturn as? T {
            completion(.success(result))
        } else {
            completion(.failure(TestError.getError))
        }
    }
    
    func post<T, Body>(_ url: String, method: HTTPMethod, body: Body?, headers: HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void) where T: Codable, Body: Codable {
        
        didCallRequest = true
        
        if let result = resultToReturn as? T {
            completion(.success(result))
        } else {
            completion(.failure(TestError.postError))
        }
    }
}
