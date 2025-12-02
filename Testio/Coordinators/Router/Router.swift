//
//  Router.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import UIKit

protocol RouterProtocol {
    
    func open(module: BaseModule, completion: (() -> Void)?)
    func openAsRoot(module: BaseModule, animated: Bool)
    
    func closeModule(animated: Bool)
    func closeToRootModule(animated: Bool, completion: (() -> Void)?)
    
    func openOverlay(
        viewController: BaseViewController, style: UIModalPresentationStyle,
        animated: Bool, completion: (() -> Void)?
    )
}

final class Router: RouterProtocol {
    
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
}
