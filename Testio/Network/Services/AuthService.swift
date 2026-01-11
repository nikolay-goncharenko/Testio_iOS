//
//  AuthService.swift
//  Testio
//
//  Created by Nick Goncharenko on 26.11.2025.
//

protocol AuthServiceProtocol {
    func signIn(
        dto: AuthRequestDTO, completion: @escaping (Result<AuthResponseDTO, Error>) -> Void
    )
}

final class AuthService: AuthServiceProtocol {
    
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
    
    internal func signIn(
        dto: AuthRequestDTO, completion: @escaping (Result<AuthResponseDTO, Error>) -> Void
    ) {
        apiClient.post(
            Endpoints.auth.url,
            method: Endpoints.auth.method,
            body: dto,
            headers: NetworkConfig.defaultHeadears
        ) { [weak self] (result: Result<AuthResponseDTO, Error>) in
            
            if let self {
                switch result {
                case .success(let response):
                    keychain.save(response.token, key: tokenKey)
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
