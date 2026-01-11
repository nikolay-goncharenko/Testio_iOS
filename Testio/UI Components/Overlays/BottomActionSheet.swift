//
//  BottomActionSheet.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

final class BottomActionSheet: BaseViewController {
    
    // MARK: - Private closures
    private var byDistance: (() -> Void)?
    private var byServer: (() -> Void)?
    
    // MARK: - Components definition
    private let dimmedView = UIView()
        .background(color: .black)
        .alpha(0)
    
    private let dividerView = UIView()
        .background(color: R.color.carbonShadow()?.withAlphaComponent(0.3))
    
    private let distanceBtn = AlertButton(
        title: "By distance",
        font: R.font.sfProTextRegular(size: 20),
        color: R.color.systemBlue(),
        style: .systemThinMaterial)
        .withUpdatedHeight(60)
    
    private let alphabetBtn = AlertButton(
        title: "Alphabetical",
        font: R.font.sfProTextRegular(size: 20),
        color: R.color.systemBlack(),
        style: .systemThinMaterial)
        .withUpdatedHeight(60)
    
    private let cancelBtn = AlertButton(
        title: "Cancel",
        font: R.font.sfProTextSemibold(size: 20),
        color: R.color.systemBlue(),
        style: .systemMaterial)
        .roundedCorners(.allCorners, radius: 14)
    
    private lazy var buttonsColumn = UIStackView()
        .addArrangedSubviews([distanceBtn, dividerView, alphabetBtn])
        .distribution(.fill)
        .axis(.vertical)
        .roundedCorners(.allCorners, radius: 14)
        .clipsToBounds(true)
    
    private lazy var primaryColumn = UIStackView()
        .addArrangedSubviews([buttonsColumn, cancelBtn])
        .distribution(.fill)
        .axis(.vertical)
        .spacing(8)
    
    // MARK: - Initializer
    init(byDistance: (() -> Void)? = nil, byServer: (() -> Void)? = nil) {
        self.byDistance = byDistance
        self.byServer = byServer
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExpandAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if primaryColumn.transform == .identity {
            primaryColumn.transform = CGAffineTransform(
                translationX: 0,
                y: primaryColumn.frame.height + 40
            )
        }
    }
    
    // MARK: - Overrided setup methods
    override func setupSubviews() {
        view.addSubviews([dimmedView, primaryColumn])
    }
    
    override func setupLayout() {
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        primaryColumn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.width.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
        }
    }
    
    override func setupHandlers() {
        distanceBtn.addAction(target: self, action: #selector(distanceBtnDidTap))
        
        alphabetBtn.addAction(target: self, action: #selector(alphabetBtnDidTap))
        
        cancelBtn.addAction(target: self, action: #selector(cancelBtnDidTap))
    }
    
    // MARK: - @objc private handlers
    @objc private  func distanceBtnDidTap() {
        performCloseAnimation { [weak self] in
            self?.byDistance?()
        }
    }
    
    @objc private func alphabetBtnDidTap() {
        performCloseAnimation { [weak self] in
            self?.byServer?()
        }
    }
    
    @objc private func cancelBtnDidTap() {
        performCloseAnimation()
    }
    
    // MARK: - ViewController anomations
    private func performExpandAnimation() {
        primaryColumn.transform = CGAffineTransform(translationX: 0, y: primaryColumn.frame.height + 40)
        dimmedView.alpha = 0.0
        
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0.4,
            options: [.curveEaseOut],
            animations: { [weak self] in
                guard let self else { return }
                self.dimmedView.alpha = 0.35
                self.primaryColumn.transform = .identity
            }
        )
    }
    
    private func performCloseAnimation(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: 0.22,
            delay: 0,
            options: [.curveEaseIn],
            animations: { [weak self] in
                guard let self else { return }
                self.dimmedView.alpha = 0.0
                self.primaryColumn.transform = CGAffineTransform(
                    translationX: 0,
                    y: self.primaryColumn.bounds.height + 40
                )
            },
            completion: { [weak self] _ in
                completion?()
                self?.dismiss(animated: false)
            }
        )
    }
}
