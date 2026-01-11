//
//  SignInViewModelTests.swift
//  Testio
//
//  Created by Nick Goncharenko on 01.12.2025.
//

import XCTest
@testable import Testio

final class SignInViewModelTests: XCTestCase {
    
    var serviceMock: AuthServiceMock!
    var viewModel: SignInViewModel!
    
    override func setUpWithError() throws {
        serviceMock = AuthServiceMock()
        viewModel = SignInViewModel(authService: serviceMock)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        serviceMock = nil
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testSignInSuccessCallbackCalled() {
        let expectedToken = "123"
        serviceMock.resultToReturn = .success(AuthResponseDTO(token: expectedToken))
        
        let expectation = expectation(description: "success")
        viewModel.onSuccess = { expectation.fulfill() }
        viewModel.onError = { _ in XCTFail("Should not call onError") }
        
        viewModel.signIn(dto: AuthRequestDTO(username: "mocked_user", password: "mocked_password"))
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(serviceMock.didCallSignIn)
    }
    
    func testSignInErrorCallbackCalled() {
        struct DummyError: Error {}
        serviceMock.resultToReturn = .failure(DummyError())
        
        let expectation = expectation(description: "error")
        viewModel.onError = { _ in expectation.fulfill() }
        viewModel.onSuccess = { XCTFail("Should not call onSuccess") }
        
        viewModel.signIn(dto: AuthRequestDTO(username: "mocked_user", password: "mocked_password"))
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(serviceMock.didCallSignIn)
    }
}
