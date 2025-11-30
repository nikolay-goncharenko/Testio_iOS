//
//  Router.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import UIKit

final class Router {
    
    // MARK: - Reference to UINavigationController
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - UINavigationController navigation
    internal func open(module: BaseModule, completion: (() -> Void)? = nil) {
        guard let navigation = navigationController else { return }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                completion?()
            }
        }
        
        navigation.pushViewController(module.viewController(), animated: true)
        CATransaction.commit()
    }
    
    internal func openAsRoot(module: BaseModule, animated: Bool = true) {
        navigationController?.setViewControllers([module.viewController()], animated: animated)
    }
    
    internal func closeModule(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    internal func closeToRootModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.popToRootViewController(animated: animated)
        completion?()
    }
    
    // MARK: - Overlay navigation
    internal func openOverlay(
        viewController: BaseViewController, style: UIModalPresentationStyle = .automatic,
        animated: Bool = true, completion: (() -> Void)? = nil
    ) {
        viewController.modalPresentationStyle = style
        navigationController?.present(viewController, animated: animated) {
            completion?()
        }
    }
    
    internal func closeModalModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.dismiss(animated: animated) {
            completion?()
        }
    }
}
