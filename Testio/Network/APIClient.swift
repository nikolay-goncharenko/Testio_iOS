//
//  APIClient.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import Foundation
import Alamofire

final class APIClient {
    
    static let shared = APIClient()
    
    private init() { }
    
    func request<T: Decodable>(
        _ url: String,
        ethod: HTTPMethod,
        parameters: Parameters? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url, method: ethod, parameters: parameters)
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
