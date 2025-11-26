//
//  Router.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import UIKit

final class Router {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func open(module: BaseModule, completion: (() -> Void)? = nil) {
        guard let navigation = navigationController else { return }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                completion?()
            }
        }
        
        let vc = module.viewController()
        
        if (vc as? UINavigationController) == nil {
            navigation.pushViewController(vc, animated: true)
        } else if let navModule = vc as? UINavigationController {
            navigation.pushViewController(navModule.viewControllers[0], animated: true)
        }
        
        CATransaction.commit()
    }
    
    func openAsRoot(module: BaseModule, animated: Bool = true) {
        navigationController?.setViewControllers([module.viewController()], animated: animated)
    }
    
    func closeModule(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func closeToRootModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.popToRootViewController(animated: animated)
        completion?()
    }
}
