//
//  BaseButton.swift
//  Testio
//
//  Created by Nick Goncharenko on 26.11.2025.
//

import UIKit

class BaseButton: UIButton {
    
    // MARK: - Overrided properties
    override var isHighlighted: Bool {
        didSet {
            alpha(isHighlighted ? 0.6 : 1.0)
        }
    }
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
