//
//  UIView+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 27.11.2025.
//

import UIKit

extension UIView {
    
    @discardableResult
    public func addSubviews(_ views: [UIView]) -> Self {
        views.forEach { self.addSubview($0) }
        return self
    }
    
    @discardableResult
    public func addGesture(target: Any?, tap: Selector?, toggle: Bool = true) -> Self {
        let touch = UITapGestureRecognizer(target: target, action: tap)
        touch.cancelsTouchesInView = toggle
        addGestureRecognizer(touch)
        return self
    }
    
    @discardableResult
    public func roundedCorners(_ corners: UIRectCorner, radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        return self
    }
    
    @discardableResult
    public func background(color: UIColor?) -> Self {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    public func alpha(_ value: CGFloat) -> Self {
        alpha = value
        return self
    }
    
    @discardableResult
    public func tint(color: UIColor?) -> Self {
        if let color {
            tintColor = color
        }
        return self
    }
    
    @discardableResult
    public func contentMode(_ value: ContentMode) -> Self {
        contentMode = value
        return self
    }
    
    @discardableResult
    public func clipsToBounds(_ value: Bool) -> Self {
        clipsToBounds = value
        return self
    }
    
    @discardableResult
    public func shadowOffset(width: CGFloat, height: CGFloat) -> Self {
        layer.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    public func shadow(color: UIColor?, alpha: CGFloat = 1) -> Self {
        layer.shadowColor = color?.withAlphaComponent(alpha).cgColor
        return self
    }
    
    @discardableResult
    public func shadow(radius: CGFloat) -> Self {
        layer.shadowRadius = radius
        return self
    }
    
    @discardableResult
    public func shadow(opacity: Float) -> Self {
        layer.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    public func isHidden(_ value: Bool) -> Self {
        isHidden = value
        return self
    }
}
