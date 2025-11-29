//
//  ReusableView+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

public extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
    static var sectionHeader: String {
        return UICollectionView.elementKindSectionHeader
    }
}
