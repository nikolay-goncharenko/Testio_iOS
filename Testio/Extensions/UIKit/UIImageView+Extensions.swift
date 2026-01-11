//
//  UIImageView+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

extension UIImageView {
    
    @discardableResult
    public func image(_ value: UIImage?, rendering: UIImage.RenderingMode = .alwaysTemplate) -> Self {
        image = value?.withRenderingMode(rendering)
        return self
    }
}
