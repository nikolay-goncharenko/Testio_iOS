//
//  BaseViewController.swift
//  Testio
//
//  Created by Nick Goncharenko on 25.11.2025.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Initializer
    init () {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupLayout()
        setupHandlers()
        bindViewModel()
    }
    
    // MARK: - Setup methods
    internal func setupSubviews() {
        fatalError("setupSubviews has not been implemented")
    }
    
    internal func setupLayout() {
        fatalError("setupLayout has not been implemented")
    }
    
    internal func setupHandlers() {
        fatalError("setupHandlers has not been implemented")
    }
    
    // MARK: - Binding
    internal func bindViewModel() {
        
    }
}
