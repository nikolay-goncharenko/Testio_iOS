//
//  ServerListService.swift
//  Testio
//
//  Created by Nick Goncharenko on 26.11.2025.
//

final class ServerListService {
    
    private let keychain = KeychainStorage()
    private let tokenKey = KeychainConfig.tokenKey
    
    internal func fetchServerList(
        completion: @escaping (Result<[ServerListResponseDTO], Error>) -> Void
    ) {
        let headers = NetworkConfig.authHeadears(withToken: keychain.get(tokenKey))
        
        APIClient.shared.get(
            Endpoints.servers.url,
            method: Endpoints.servers.method,
            headers: headers) { (result: Result<[ServerListResponseDTO], Error>) in
                
                switch result {
                case .success(let response):
                    completion(.success(response))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
