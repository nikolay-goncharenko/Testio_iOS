//
//  TitleLabel.swift
//  Testio
//
//  Created by Nick Goncharenko on 26.11.2025.
//

import UIKit

final class TitleLabel: UILabel {
    
    // MARK: - Initializer
    init(_ title: String) {
        super.init(frame: .zero)
        
        text(text: title)
        text(alignment: .center)
        text(color: R.color.systemBlack())
        text(font: R.font.sfProTextSemibold(size: 18))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
