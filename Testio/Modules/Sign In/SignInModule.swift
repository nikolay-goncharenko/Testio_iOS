//
//  SignInModule.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import Foundation

final class SignInModule: BaseModule {
    
    let viewModel: SignInViewModel
    let view: SignInViewController
    
    init() {
        viewModel = SignInViewModel()
        view = SignInViewController(viewModel: viewModel)
    }
    
    func viewController() -> BaseViewController {
        return view
    }
}
