//
//  NavigationHeaderView.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

final class NavigationHeaderView: UIStackView {
    
    // MARK: - Internal closures
    internal var filterBtnDidTouch: (() -> Void)?
    internal var signOutBtnDidTouch: (() -> Void)?
    
    // MARK: - Components definition
    private let titleLbl = TitleLabel("Testio.")
    
    private let filterBtn = NavigationHeaderButton(
        iconSide: .left,
        icon: R.image.sortIcon(),
        title: "Filter"
    )
    
    private let signOutBtn = NavigationHeaderButton(
        iconSide: .right,
        icon: R.image.logoutIcon(),
        title: "Logout"
    )
    
    // MARK: - Header row components
    private lazy var headerRow = UIStackView()
        .addArrangedSubviews([filterBtn, titleLbl, signOutBtn])
        .distribution(.equalCentering)
        .axis(.horizontal)
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
        setupLayout()
        setupShadow()
        setupHandlers()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private setup methods
    private func setupSubviews() {
        addArrangedSubviews([UIView(), headerRow])
        background(color: R.color.frostWhite())
        distribution(.fill)
        axis(.vertical)
    }
    
    private func setupLayout() {
        headerRow.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        snp.makeConstraints { make in
            make.height.equalTo(Screen.statusBarHeight + 44)
        }
    }
    
    private func setupShadow() {
        shadowOffset(width: 0, height: 0.5)
        shadow(color: R.color.systemBlack()?.withAlphaComponent(0.3))
        shadow(opacity: 1)
        shadow(radius: 1)
    }
    
    private func setupHandlers() {
        filterBtn.didTouch = { [weak self] in
            if let self {
                print("Filter button did touch")
                self.filterBtnDidTouch?()
            }
        }
        
        signOutBtn.didTouch = { [weak self] in
            if self != nil {
                print("Logout button did touch")
                self?.signOutBtnDidTouch?()
            }
        }
    }
}
