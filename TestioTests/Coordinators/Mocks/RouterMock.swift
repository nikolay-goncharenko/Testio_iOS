//
//  RouterMock.swift
//  Testio
//
//  Created by Nick Goncharenko on 02.12.2025.
//

import UIKit
@testable import Testio

final class RouterMock: RouterProtocol {
    
    // MARK: - Open Module
    var didOpenModule = false
    var openedModule: BaseModule?
    var openCompletionCalled = false
    
    func open(module: BaseModule, completion: (() -> Void)?) {
        didOpenModule = true
        openedModule = module
        completion?()
        openCompletionCalled = completion != nil
    }
    
    // MARK: - Open Module As Root
    var didOpenRootModule = false
    var openedRootModule: BaseModule?
    var openAsRootAnimated: Bool = false
    
    func openAsRoot(module: BaseModule, animated: Bool) {
        didOpenRootModule = true
        openedRootModule = module
        openAsRootAnimated = animated
    }
    
    // MARK: - Close Module
    var didCloseModule = false
    var closeModuleAnimated = false
    
    func closeModule(animated: Bool) {
        didCloseModule = true
        closeModuleAnimated = animated
    }
    
    // MARK: - Close Module To Root
    var didCloseToRoot = false
    var closeToRootAnimated = false
    var closeToRootCompletionCalled = false
    
    func closeToRootModule(animated: Bool, completion: (() -> Void)?) {
        didCloseToRoot = true
        closeToRootAnimated = animated
        completion?()
        closeToRootCompletionCalled = completion != nil
    }
    
    // MARK: - Open Overlay
    var didOpenOverlay = false
    var overlayViewController: BaseViewController?
    var overlayStyle: UIModalPresentationStyle?
    var overlayAnimated = false
    var overlayCompletionCalled = false
    
    func openOverlay(
        viewController: BaseViewController,
        style: UIModalPresentationStyle,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        didOpenOverlay = true
        overlayViewController = viewController
        overlayStyle = style
        overlayAnimated = animated
        completion?()
        overlayCompletionCalled = completion != nil
    }
}
