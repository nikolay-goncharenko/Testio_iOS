//
//  SignInNavigation.swift
//  Testio
//
//  Created by Nick Goncharenko on 30.11.2025.
//

import UIKit

protocol SignInNavigation: AnyObject {
    
    func openServerListScreen()
    
    func showCenterActionAlert()
}

extension AppCoordinator: SignInNavigation {
    
    func openServerListScreen() {
        let module = ServerListModule(navigator: self)
        router.openAsRoot(module: module)
    }
    
    func showCenterActionAlert() {
        router.openOverlay(
            viewController: CenterActionAlert(),
            style: .overCurrentContext,
            animated: false
        )
    }
}
