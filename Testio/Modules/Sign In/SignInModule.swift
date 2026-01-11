//
//  SignInModule.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import Foundation

final class SignInModule: BaseModule {
    
    // MARK: - Private instances
    private let viewModel: SignInViewModel
    private let view: SignInViewController
    
    // MARK: - Initializer
    init(navigator: SignInNavigation) {
        viewModel = SignInViewModel()
        viewModel.navigator = navigator
        view = SignInViewController(viewModel: viewModel)
    }
    
    // MARK: - Method for accessing ViewController
    internal func viewController() -> BaseViewController {
        return view
    }
}
