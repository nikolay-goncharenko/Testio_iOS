//
//  AppCoordinator.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let router: Router
    
    init(navigationController: UINavigationController) {
        self.router = Router(navigationController: navigationController)
        navigationController.navigationBar.isHidden = true
    }
    
    override func start() {
        openLoginScreen()
        print("AppCoordinator was started")
    }
    
    func openLoginScreen() {
        router.openAsRoot(module: SignInModule())
//        router.openAsRoot(module: ServerListModule())
    }
}
