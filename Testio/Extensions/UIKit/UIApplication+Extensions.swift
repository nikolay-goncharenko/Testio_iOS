//
//  UIApplication+Extensions.swift
//  Testio
//
//  Created by Nick Goncharenko on 28.11.2025.
//

import UIKit

extension UIApplication {
    
    static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first?
                .statusBarManager?
                .statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
}
