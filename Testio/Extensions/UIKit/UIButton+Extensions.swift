//
//  UIButton+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 27.11.2025.
//

import UIKit

extension UIButton {
    
    @discardableResult
    public func addAction(target: Any?, action: Selector, event: UIControl.Event = .touchUpInside) -> Self {
        addTarget(target, action: action, for: event)
        return self
    }
    
    @discardableResult
    public func text(text: String?, state: UIControl.State = .normal) -> Self {
        setTitle(text, for: state)
        return self
    }
    
    @discardableResult
    public func text(color: UIColor?, state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    public func text(font: UIFont?, state: UIControl.State = .normal) -> Self {
        guard let font = font else { return self }
        titleLabel?.font = font
        return self
    }
    
    @discardableResult
    public func text(alignment: NSTextAlignment) -> Self {
        self.titleLabel?.textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func image(image: UIImage?, rendering: UIImage.RenderingMode = .alwaysTemplate, state: UIControl.State = .normal) -> Self {
        setImage(image?.withRenderingMode(rendering), for: state)
        return self
    }
    
    @discardableResult
    public func image(tint: UIColor?) -> Self {
        imageView?.tintColor = tint
        return self
    }
    
    @discardableResult
    public func content(_ direction: UISemanticContentAttribute) -> Self {
        semanticContentAttribute = direction
        return self
    }
    
    @discardableResult
    public func content(horizontalAlignment: ContentHorizontalAlignment) -> Self {
        self.contentHorizontalAlignment = horizontalAlignment
        return self
    }
    
    @discardableResult
    public func contentEdgeInsets(left: CGFloat = 0, right: CGFloat = 0) -> Self {
        contentEdgeInsets = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        return self
    }
    
    @discardableResult
    public func titleEdgeInsets(left: CGFloat = 0, right: CGFloat = 0) -> Self {
        titleEdgeInsets = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        return self
    }
}
