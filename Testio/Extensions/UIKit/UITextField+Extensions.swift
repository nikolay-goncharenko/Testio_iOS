//
//  UITextField+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 27.11.2025.
//

import UIKit

extension UITextField {
    
    @discardableResult
    public func delegate(_ value: UITextFieldDelegate) -> Self {
        self.delegate = value
        return self
    }
    
    @discardableResult
    public func placeholder(text: String, font: UIFont?, color: UIColor?) -> Self {
        if let font, let color {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: color,
                .font: font
            ]
            
            attributedPlaceholder = NSAttributedString(
                string: text,
                attributes: attributes
            )
        } else {
            placeholder = text
        }
        return self
    }
    
    @discardableResult
    public func text(text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    public func text(font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    public func text(color: UIColor?) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    public func keyboardType(_ value: UIKeyboardType) -> Self {
        self.keyboardType = value
        return self
    }
    
    @discardableResult
    public func returnKeyType(_ value: UIReturnKeyType) -> Self {
        self.returnKeyType = value
        return self
    }
    
    @discardableResult
    public func isSecureTextEntry(_ value: Bool) -> Self {
        isSecureTextEntry = value
        return self
    }
    
    @discardableResult
    public func tag(_ value: Int) -> Self {
        tag = value
        return self
    }
}
