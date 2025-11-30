//
//  ServerListNavigation.swift
//  Testio
//
//  Created by Nick Goncharenko on 30.11.2025.
//

import UIKit

protocol ServerListNavigation: AnyObject {
    
    func openSignInScreen()
    
    func showBottomActionSheet(byDistance: (() -> Void)?, byServer: (() -> Void)?)
}

extension AppCoordinator: ServerListNavigation {
    
    func openSignInScreen() {
        let module = SignInModule(navigator: self)
        router.openAsRoot(module: module)
    }
    
    func showBottomActionSheet(byDistance: (() -> Void)? = nil, byServer: (() -> Void)? = nil) {
        router.openOverlay(
            viewController: BottomActionSheet(
                byDistance: byDistance,
                byServer: byServer
            ),
            style: .overCurrentContext,
            animated: false
        )
    }
}
