//
//  ServersListCell.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

final class ServersListCell: UICollectionViewCell, ReusableCell {
    
    // MARK: - Components definition
    private lazy var serverValueLbl = createLabel(title: "Canada #10")
    
    private lazy var distanceValueLbl = createLabel(title: "4073 km")
    
    private let dividerView = UIView()
        .background(color: R.color.carbonShadow()?.withAlphaComponent(0.3))
    
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
            .text(text: title)
            .text(alignment: .left)
            .text(font: R.font.sfProTextRegular(size: 18))
            .text(color: R.color.systemBlack())
    }
    
    // MARK: - Private setup methods
    private func setupSubviews() {
        contentView.background(color: R.color.systemWhite())
        contentView.addSubviews([serverValueLbl, distanceValueLbl, dividerView])
    }
    
    private func setupLayout() {
        [serverValueLbl, distanceValueLbl].forEach { labels in
            labels.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
            }
        }
        
        serverValueLbl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
        }
        
        distanceValueLbl.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(87)
        }
        
        dividerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // MARK: - Internal setters
    internal func setServerValue(_ value: String) {
        serverValueLbl.text(text: value)
    }
    
    internal func setDistanceValue(_ value: String) {
        distanceValueLbl.text(text: value)
    }
}
