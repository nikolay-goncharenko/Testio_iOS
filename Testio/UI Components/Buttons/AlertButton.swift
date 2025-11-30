//
//  AlertButton.swift
//  Testio
//
//  Created by Nick Goncharenko on 29.11.2025.
//

import UIKit

final class AlertButton: UIButton {
    
    // MARK: - BlurEffect definition
    internal enum BlurEffect {
        case systemMaterial
        case systemThinMaterial
        case systemMaterialLight
        
        var blurEffect: UIBlurEffect {
            switch self {
            case .systemMaterial:
                return UIBlurEffect(style: .systemMaterial)
            case .systemThinMaterial:
                return UIBlurEffect(style: .systemThinMaterial)
            case .systemMaterialLight:
                return UIBlurEffect(style: .systemMaterialLight)
            }
        }
    }
    
    // MARK: - BlurView definition
    private var blurView: UIVisualEffectView
    
    // MARK: - HighlightView definition
    private let highlightView = UIView()
        .background(color: R.color.fadedGraphite())
        .alpha(0)
    
    // MARK: - Button highlight overriding
    override var isHighlighted: Bool {
        didSet {
            titleLabel?.alpha(isHighlighted ? 0.6 : 1.0)
            animate(when: isHighlighted)
        }
    }
    
    // MARK: - Initializer
    init(title: String, font: UIFont?, color: UIColor?, style: BlurEffect) {
        self.blurView = Self.createBlurView(with: style.blurEffect)
        super.init(frame: .zero)
        
        text(text: title)
        text(font: font)
        text(color: color)
        clipsToBounds(true)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private creation methods
    private static func createBlurView(with style: UIBlurEffect) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: style)
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }
    
    private func animate(when isHighlighted: Bool) {
        UIView.animate(withDuration: isHighlighted ? 0.05 : 0.25) { [weak self] in
            if let self {
                highlightView.alpha(isHighlighted ? 1.0 : 0.0)
            }
        }
    }
    
    // MARK: - Private setup methods
    private func setupSubviews() {
        insertSubview(blurView, at: 0)
        insertSubview(highlightView, at: 1)
    }
    
    private func setupLayout() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        highlightView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        snp.updateConstraints { update in
            update.height.equalTo(56)
        }
    }
    
    // MARK: - Internal setters
    internal func withUpdatedHeight(_ height: CGFloat) -> Self {
        snp.updateConstraints { update in
            update.height.equalTo(height)
        }
        return self
    }
}
