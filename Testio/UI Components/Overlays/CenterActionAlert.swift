//
//  CenterActionAlert.swift
//  Testio
//
//  Created by Nick Goncharenko on 29.11.2025.
//

import UIKit

final class CenterActionAlert: BaseViewController {
    
    // MARK: - Components definition
    private let dimmedView = UIView()
        .background(color: .black)
        .alpha(0)
    
    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let titleLbl = UILabel()
        .text(text: "Verification Failed")
        .text(font: R.font.sfProTextSemibold(size: 18))
        .text(color: R.color.systemBlack())
        .text(alignment: .center)
    
    private let descriptionLbl = UILabel()
        .text(text: "Your username or password is incorrect.")
        .text(font: R.font.sfProTextRegular(size: 14))
        .text(color: R.color.systemBlack())
        .text(alignment: .center)
        .numberOfLines(0)
    
    private let dividerView = UIView()
        .background(color: R.color.carbonShadow()?.withAlphaComponent(0.3))
    
    private let okBtn = AlertButton(
        title: "OK",
        font: R.font.sfProTextRegular(size: 18),
        color: R.color.systemBlue(),
        style: .systemThinMaterial)
        .withUpdatedHeight(44)
    
    private lazy var messageColumn = UIStackView()
        .addArrangedSubviews([titleLbl, descriptionLbl])
        .distribution(.fill)
        .alignment(.center)
        .axis(.vertical)
        .spacing(2)
        .edgeInsets(horizontal: 16, vertical: 19)
    
    private lazy var primaryColumn = UIStackView()
        .addArrangedSubviews([messageColumn, dividerView, okBtn])
        .distribution(.fill)
        .axis(.vertical)
        .roundedCorners(.allCorners, radius: 14)
        .clipsToBounds(true)
        
    
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
        
        messageColumn.insertSubview(blurView, at: 0)
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupLayout() {
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        primaryColumn.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(52)
            make.center.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
        }
    }
    
    override func setupHandlers() {
        okBtn.addAction(target: self, action: #selector(okBtnDidTap))
    }
    
    // MARK: - @objc private handlers
    @objc func okBtnDidTap() {
        performCloseAnimation()
    }
    
    // MARK: - ViewController animations
    private func performExpandAnimation() {
        primaryColumn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        primaryColumn.alpha = 0.0
        dimmedView.alpha = 0.0
        
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0.5,
            options: [.curveEaseOut],
            animations: { [weak self] in
                guard let self = self else { return }
                self.dimmedView.alpha = 0.35
                self.primaryColumn.alpha = 1.0
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
                guard let self = self else { return }
                self.dimmedView.alpha = 0.0
                self.primaryColumn.alpha = 0.0
                self.primaryColumn.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            },
            completion: { [weak self] _ in
                completion?()
                self?.dismiss(animated: false)
            }
        )
    }
}
