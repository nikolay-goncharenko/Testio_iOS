//
//  SignInViewController.swift
//  Testio
//
//  Created by Nick Goncharenko on 24.11.2025.
//

import UIKit

final class SignInViewController: BaseViewController {
    
    private let viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var titleLbl = UILabel()
    
    override func setupSubviews() {
        titleLbl.text = "Hello, world!"
        
        view.backgroundColor = .systemGreen
        view.addSubview(titleLbl)
    }
    
    override func setupLayout() {
        titleLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    override func setupHandlers() {
        
    }
    
    override func bindViewModel() {
        
    }
}

