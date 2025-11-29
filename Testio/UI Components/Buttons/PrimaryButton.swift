//
//  PrimaryButton.swift
//  Testio
//
//  Created by Nick Goncharenko on 26.11.2025.
//

import UIKit

final class PrimaryButton: BaseButton {
    
    // MARK: - Initializer
    init(title: String) {
        super.init()
        
        text(text: title)
        text(alignment: .center)
        text(font: R.font.sfProTextRegular(size: 16))
        text(color: R.color.systemWhite())
        
        background(color: R.color.systemBlue())
        roundedCorners(.allCorners, radius: 10)
        
        snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
