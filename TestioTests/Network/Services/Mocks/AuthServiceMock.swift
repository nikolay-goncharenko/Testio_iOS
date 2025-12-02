//
//  AuthServiceMock.swift
//  Testio
//
//  Created by Nick Goncharenko on 01.12.2025.
//

import Foundation
@testable import Testio

final class AuthServiceMock: AuthServiceProtocol {
    
    var resultToReturn: Result<AuthResponseDTO, Error>?
    var didCallSignIn = false
    
    func signIn(
        dto: AuthRequestDTO, completion: @escaping (Result<AuthResponseDTO, Error>) -> Void
    ) {
        didCallSignIn = true
        
        if let result = resultToReturn {
            completion(result)
        }
    }
}
