//
//  APIClient.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import Foundation
import Alamofire

protocol APIClientProtocol {
    
    func get<T: Codable>(
        _ url: String,
        method: HTTPMethod,
        headers: HTTPHeaders?,
        completion: @escaping (Result<T, Error>) -> Void
    )
    
    func post<T: Codable, Body: Codable>(
        _ url: String,
        method: HTTPMethod,
        body: Body?,
        headers: HTTPHeaders?,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class APIClient: APIClientProtocol {
    
    // MARK: - Singleton
    static let shared = APIClient()
    
    // MARK: - Private initializer
    private init() { }
    
    // MARK: - GET method
    internal func get<T: Codable>(
        _ url: String,
        method: HTTPMethod,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url, method: method, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // MARK: - POST method
    internal func post<T: Codable, Body: Codable>(
        _ url: String,
        method: HTTPMethod,
        body: Body? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url, method: method, parameters: body, encoder: .json, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
