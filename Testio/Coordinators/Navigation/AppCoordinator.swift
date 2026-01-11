//
//  AppCoordinator.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Router & Keychain
    internal var router: RouterProtocol
    internal var keychain: KeychainStorageProtocol
    
    // MARK: - initializer
    init(
        navigationController: UINavigationController,
        router: RouterProtocol? = nil,
        keychain: KeychainStorageProtocol = KeychainStorage()
    ) {
        self.router = router ?? Router(navigationController: navigationController)
        self.keychain = keychain
        navigationController.navigationBar.isHidden = true
    }
    
    // MARK: - Starting method
    internal func start() {
        if keychain.get(KeychainConfig.tokenKey) != nil {
            router.openAsRoot(module: ServerListModule(navigator: self), animated: true)
        } else {
            router.openAsRoot(module: SignInModule(navigator: self), animated: true)
        }
    }
}
