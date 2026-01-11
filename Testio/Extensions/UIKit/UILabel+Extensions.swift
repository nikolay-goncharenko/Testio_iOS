//
//  UILabel+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 27.11.2025.
//

import UIKit

extension UILabel {
    
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
    public func text(alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func text(color: UIColor?) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    public func numberOfLines(_ value: Int) -> Self {
        numberOfLines = value
        return self
    }
}
