//
//  AppCoordinator.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Router instance
    internal let router: Router
    
    // MARK: - initializer
    init(navigationController: UINavigationController) {
        self.router = Router(navigationController: navigationController)
        navigationController.navigationBar.isHidden = true
    }
    
    // MARK: - Starting method
    internal func start() {
        let keychain = KeychainStorage()
        
        if keychain.get(KeychainConfig.tokenKey) != nil {
            router.openAsRoot(module: ServerListModule(navigator: self))
        } else {
            router.openAsRoot(module: SignInModule(navigator: self))
        }
    }
}
