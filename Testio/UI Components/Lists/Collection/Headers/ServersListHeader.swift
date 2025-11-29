//
//  ServersListHeader.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

final class ServersListHeader: UICollectionReusableView, ReusableView {
    
    // MARK: - Components definition
    private lazy var serverLbl = createLabel(title: "Server")
    
    private lazy var distanceLbl = createLabel(title: "Distance")
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private creation methods
    private func createLabel(title: String) -> UILabel {
        return UILabel()
            .text(text: title.uppercased())
            .text(font: R.font.sfProTextRegular(size: 12))
            .text(color: R.color.steelGray())
    }
    
    // MARK: - Private setup methods
    private func setupSubviews() {
        background(color: R.color.softPearl())
        addSubviews([serverLbl, distanceLbl])
    }
    
    private func setupLayout() {
        [serverLbl, distanceLbl].forEach { labels in
            labels.snp.makeConstraints { make in
                make.bottom.equalToSuperview().inset(8)
            }
        }
        
        serverLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
        }
        
        distanceLbl.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(38)
        }
    }
}
