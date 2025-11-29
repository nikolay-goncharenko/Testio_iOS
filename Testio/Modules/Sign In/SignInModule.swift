//
//  SignInModule.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import Foundation

final class SignInModule: BaseModule {
    
    private let viewModel: SignInViewModel
    private let view: SignInViewController
    
    init() {
        viewModel = SignInViewModel()
        view = SignInViewController(viewModel: viewModel)
    }
    
    internal func viewController() -> BaseViewController {
        return view
    }
}
