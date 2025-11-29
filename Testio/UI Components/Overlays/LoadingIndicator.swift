//
//  LoadingIndicator.swift
//  Testio
//
//  Created by Nick Goncharenko on 29.11.2025.
//

import UIKit

final class LoadingIndicator: UIStackView {
    
    // MARK: - Components definition
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = R.color.coolSlate()
        activityView.startAnimating()
        return activityView
    }()
    
    private let titleLbl = UILabel()
        .text(text: "Loading list")
        .text(font: R.font.sfProTextRegular(size: 14))
        .text(color: R.color.carbonShadow()?.withAlphaComponent(0.6))
        .text(alignment: .center)
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        
        addArrangedSubviews([loadingIndicator, titleLbl])
        distribution(.fill)
        alignment(.center)
        axis(.vertical)
        spacing(8)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
