//
//  ServerListModule.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import Foundation

final class ServerListModule: BaseModule {
    
    private let viewModel: ServerListViewModel
    private let view: ServerListViewController
    
    init () {
        viewModel = ServerListViewModel()
        view = ServerListViewController(viewModel: viewModel)
    }
    
    internal func viewController() -> BaseViewController {
        return view
    }
}
