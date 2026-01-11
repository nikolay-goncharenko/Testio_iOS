//
//  UIStackView+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 27.11.2025.
//

import UIKit

extension UIStackView {
    
    @discardableResult
    public func addArrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach { self.addArrangedSubview($0) }
        return self
    }
    
    @discardableResult
    public func distribution(_ value: UIStackView.Distribution) -> Self {
        distribution = value
        return self
    }
    
    @discardableResult
    public func alignment(_ value: UIStackView.Alignment) -> Self {
        alignment = value
        return self
    }
    
    @discardableResult
    public func axis(_ value: NSLayoutConstraint.Axis) -> Self {
        axis = value
        return self
    }
    
    @discardableResult
    public func spacing(_ value: CGFloat) -> Self {
        spacing = value
        return self
    }
    
    @discardableResult
    public func edgeInsets(
        top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0
    ) -> Self {
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: top, leading: left, bottom: bottom, trailing: right
        )
        return self
    }
    
    @discardableResult
    public func edgeInsets(horizontal horz: CGFloat, vertical vert: CGFloat) -> Self {
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: vert, leading: horz, bottom: vert, trailing: horz)
        return self
    }
}
