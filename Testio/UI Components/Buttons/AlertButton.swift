//
//  AlertButton.swift
//  Testio
//
//  Created by Nick Goncharenko on 29.11.2025.
//

import UIKit

final class AlertButton: BaseButton {
    
    // MARK: - BlurEffect definition
    internal enum BlurEffect {
        case systemMaterial
        case systemThinMaterial
        
        var blurEffect: UIBlurEffect {
            switch self {
            case .systemMaterial:
                return UIBlurEffect(style: .systemMaterial)
            case .systemThinMaterial:
                return UIBlurEffect(style: .systemThinMaterial)
            }
        }
    }
    
    private var blurView: UIVisualEffectView
    
    // MARK: - Initializer
    init(title: String, font: UIFont?, color: UIColor?, style: BlurEffect) {
        self.blurView = Self.createBlurView(with: style.blurEffect)
        super.init()
        
        insertSubview(blurView, at: 0)
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        snp.updateConstraints { update in
            update.height.equalTo(56)
        }
        
        text(text: title)
        text(font: font)
        text(color: color)
        clipsToBounds(true)
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
    
    // MARK: - Internal setters
    internal func withUpdatedHeight(_ height: CGFloat) -> Self {
        snp.updateConstraints { update in
            update.height.equalTo(height)
        }
        return self
    }
}
