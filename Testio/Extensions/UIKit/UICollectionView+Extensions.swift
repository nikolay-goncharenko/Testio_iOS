//
//  UICollectionView+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

extension UICollectionView {
    
    @discardableResult
    public func registerHeader<T: ReusableView & UICollectionReusableView>(_ view: T.Type) -> Self {
        register(view, forSupplementaryViewOfKind: view.sectionHeader,
                 withReuseIdentifier: view.reuseIdentifier)
        return self
    }
    
    @discardableResult
    public func registerCell<T: ReusableCell & UICollectionViewCell>(_ cell: T.Type) -> Self {
        register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
        return self
    }
    
    func dequeueReusableHeader<T>(_ indexPath: IndexPath) -> T where T: ReusableView {
        let type = T.self
        
        if let header = dequeueReusableSupplementaryView(
            ofKind: type.sectionHeader,
            withReuseIdentifier: type.reuseIdentifier,
            for: indexPath) as? T {
            return header
        } else {
            fatalError("header dequeue failed")
        }
    }
    
    func dequeueReusableCell<T>(_ indexPath: IndexPath) -> T where T: ReusableCell {
        let type = T.self
        
        if let cell = self.dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier,
                                               for: indexPath) as? T {
            return cell
        } else {
            fatalError("cell dequeue failed")
        }
    }
    
    @discardableResult
    public func dataSource(_ value: UICollectionViewDataSource) -> Self {
        dataSource = value
        return self
    }
    
    @discardableResult
    public func delegate(_ value: UICollectionViewDelegate) -> Self {
        delegate = value
        return self
    }
}
