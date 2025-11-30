//
//  SignInViewModel.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import  Foundation

final class SignInViewModel {
    
    // MARK: - Coordinator reference
    internal weak var navigator: SignInNavigation?
    
    // MARK: - Internal closure with server list
    internal var onSuccess: (() -> Void)?
    internal var onError: ((Error) -> Void)?
    
    // MARK: - Authorization service instance
    private let authService = AuthService()
    
    // MARK: - SignIn handler
    internal func signIn(dto: AuthRequestDTO) {
        authService.signIn(dto: dto) { [weak self] (result: Result<AuthResponseDTO, Error>) in
            if let self {
                switch result {
                case .success(_):
                    onSuccess?()
                case .failure(let error):
                    onError?(error)
                }
            }
        }
    }
}
