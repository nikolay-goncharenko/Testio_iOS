//
//  LoginModule.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import Foundation

final class LoginModule: BaseModule {
    
    let viewModel: LoginViewModel
    let view: LoginViewController
    
    init() {
        viewModel = LoginViewModel()
        view = LoginViewController(viewModel: viewModel)
    }
    
    func viewController() -> BaseViewController {
        return view
    }
}
