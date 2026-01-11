//
//  ServerListService.swift
//  Testio
//
//  Created by Nick Goncharenko on 26.11.2025.
//

protocol ServerListServiceProtocol {
    func fetchServerList(
        completion: @escaping (Result<[ServerListResponseDTO], Error>) -> Void
    )
}

final class ServerListService: ServerListServiceProtocol {
    
    private let apiClient: APIClientProtocol
    private let keychain: KeychainStorageProtocol
    private let tokenKey: String
    
    init(
        apiClient: APIClientProtocol = APIClient.shared,
        keychain: KeychainStorageProtocol = KeychainStorage(),
        tokenKey: String = KeychainConfig.tokenKey
    ) {
        self.apiClient = apiClient
        self.keychain = keychain
        self.tokenKey = tokenKey
    }
    
    internal func fetchServerList(
        completion: @escaping (Result<[ServerListResponseDTO], Error>) -> Void
    ) {
        let headers = NetworkConfig.authHeadears(withToken: keychain.get(tokenKey))
        
        apiClient.get(
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
