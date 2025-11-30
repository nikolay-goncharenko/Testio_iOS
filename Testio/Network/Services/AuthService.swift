//
//  AuthService.swift
//  Testio
//
//  Created by Nick Goncharenko on 26.11.2025.
//

final class AuthService {
    
    private let keychain = KeychainStorage()
    private let tokenKey = KeychainConfig.tokenKey
    
    internal func signIn(
        dto: AuthRequestDTO, completion: @escaping (Result<AuthResponseDTO, Error>) -> Void
    ) {
        APIClient.shared.post(
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
