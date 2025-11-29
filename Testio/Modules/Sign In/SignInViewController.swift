//
//  SignInViewController.swift
//  Testio
//
//  Created by Nick Goncharenko on 24.11.2025.
//

import UIKit

final class SignInViewController: BaseViewController {
    
    // MARK: - ViewModel instance
    private let viewModel: SignInViewModel
    
    // MARK: - KeyBoard observer & Constraints
    private lazy var keyboardObserver = KeyboardObserver(on: view)
    private var centerYConstraint: Constraint?
    private var bottomConstraint: Constraint?
    private var isKeyboardVisible = false
    
    // MARK: - Components definition
    private let logoImg = UIImageView(image: R.image.logoImg())
    
    private let usernameFld = FormTextField(icon: R.image.userIcon(), placeholder: "Username")
        .keyboardType(.default)
        .returnKeyType(.next)
        .tagName(.first)
    
    private let passwordFld = FormTextField(icon: R.image.passwordIcon(), placeholder: "Password")
        .isSecureTextEntry(true)
        .keyboardType(.default)
        .returnKeyType(.done)
        .tagName(.last)
    
    private let signInBtn = PrimaryButton(title: "Log in")
    
    private let bottomImg = UIImageView(image: R.image.loginBackgroundImg())
    
    private lazy var signInColumn = UIStackView()
        .addArrangedSubviews([usernameFld, passwordFld, signInBtn])
        .distribution(.fill)
        .alignment(.center)
        .axis(.vertical)
        .spacing(24)
    
    // MARK: - Initializer
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardObserver.startObserving { [weak self] keyboardHeight in
            
            if let self, !self.isKeyboardVisible {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.isKeyboardVisible = true
                    
                    self.centerYConstraint?.deactivate()
                    self.bottomConstraint?.update(inset: keyboardHeight + 32)
                    self.bottomConstraint?.activate()
                    
                    UIView.animate(withDuration: 0.25) {
                        self.view.layoutIfNeeded()
                    }
                }
            }
            
        } onHide: { [weak self] in
            
            if let self, self.isKeyboardVisible {
                self.isKeyboardVisible = false
                
                self.bottomConstraint?.deactivate()
                self.centerYConstraint?.activate()
                
                UIView.animate(withDuration: 0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardObserver.stopObserving()
    }
    
    // MARK: - Setup methonds
    override func setupSubviews() {
        view.background(color: R.color.systemWhite())
        view.addSubviews([logoImg, signInColumn])
        view.insertSubview(bottomImg, at: 0)
        
        [usernameFld, passwordFld].forEach { textField in
            textField.backgroundColor = R.color.fadedGraphite()
        }
    }
    
    override func setupLayout() {
        signInColumn.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
            
            centerYConstraint = make.centerY.equalToSuperview().constraint
            bottomConstraint = make.bottom.equalToSuperview().inset(0).constraint
        }
        bottomConstraint?.deactivate()
        
        
        logoImg.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 186, height: 48))
            make.bottom.equalTo(signInColumn.snp.top).offset(-40)
            make.centerX.equalToSuperview()
        }
        
        [usernameFld, passwordFld].forEach { textField in
            textField.snp.makeConstraints { make in
                make.width.equalToSuperview()
            }
        }
        
        signInBtn.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        bottomImg.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupHandlers() {
        view.addGesture(target: self, tap: #selector(dismissKeyboard))
        
        signInBtn.addAction(target: self, action: #selector(signInAction))
    }
    
    // MARK: - Binding
    override func bindViewModel() {
        viewModel.onSuccess = { [weak self] in
            print("onSuccess")
        }
        
        viewModel.onError = { [weak self] in
            print("onError")
        }
    }
    
    // MARK: - @objc private handlers
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func signInAction() {
        print("SignIn button tapped")
    }
}

