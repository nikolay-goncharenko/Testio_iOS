//
//  NavigationHeaderButton.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

final class NavigationHeaderButton: BaseButton {
    
    // MARK: - Definition type for button's icon side
    internal enum IconSide {
        case left
        case right
        
        var semantic: UISemanticContentAttribute {
            switch self {
            case .left:
                return .forceLeftToRight
            case .right:
                return .forceRightToLeft
            }
        }
    }
    
    // MARK: - Internal closures
    internal var didTouch: (() -> Void)?
    
    // MARK: - Initialier
    init(iconSide: IconSide, icon: UIImage?, title: String) {
        super.init()
        
        setupContent(for: iconSide)
        setupIcon(with: icon)
        setupTitle(with: title)
        setupInsets(for: iconSide)
        setupLayout()
        setupHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal setters
    internal func withUpdatedWidth(_ width: CGFloat) -> Self {
        snp.updateConstraints { update in
            update.width.equalTo(width)
        }
        return self
    }
    
    // MARK: - Private setup methods
    private func setupContent(for side: IconSide) {
        content(horizontalAlignment: side == .left ? .left : .right)
        contentMode(.scaleAspectFit)
        content(side.semantic)
    }
    
    private func setupIcon(with icon: UIImage?) {
        image(tint: R.color.systemBlue())
        image(image: icon)
    }
    
    private func setupTitle(with title: String) {
        text(font: R.font.sfProTextRegular(size: 18))
        text(color: R.color.systemBlue())
        text(text: title)
    }
    
    private func setupInsets(for side: IconSide) {
        switch side {
        case .left:
            contentEdgeInsets(left: 9)
            titleEdgeInsets(left: 10)
        case .right:
            contentEdgeInsets(right: 9)
            titleEdgeInsets(right: 10)
        }
    }
    
    private func setupLayout() {
        snp.makeConstraints { make in
            make.width.equalTo(100)
        }
    }
    
    private func setupHandlers() {
        addAction(target: self, action: #selector(buttonDidTouch))
    }
    
    // MARK: - @objc private handlers
    @objc private func buttonDidTouch() {
        didTouch?()
    }
}
