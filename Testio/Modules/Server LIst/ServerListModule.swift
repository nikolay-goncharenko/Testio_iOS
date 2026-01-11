//
//  ServerListModule.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import Foundation

final class ServerListModule: BaseModule {
    
    // MARK: - Private instances
    private let viewModel: ServerListViewModel
    private let view: ServerListViewController
    
    // MARK: - Initialzer
    init (navigator: ServerListNavigation) {
        viewModel = ServerListViewModel()
        viewModel.navigator = navigator
        view = ServerListViewController(viewModel: viewModel)
    }
    
    // MARK: - Method for accessing ViewController
    internal func viewController() -> BaseViewController {
        return view
    }
}
