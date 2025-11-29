//
//  ReusableCell+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import Foundation

public protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

public extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
