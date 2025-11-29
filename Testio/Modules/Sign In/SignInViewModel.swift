//
//  SignInViewModel.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import  Foundation

final class SignInViewModel {
    
    private let authService = AuthService()
    
    internal var onSuccess: (() -> Void)?
    internal var onError: (() -> Void)?
    
    internal func signIn(username: String, password: String) {
        authService.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                self.onSuccess?()
            case .failure:
                self.onError?()
            }
        }
    }
}
