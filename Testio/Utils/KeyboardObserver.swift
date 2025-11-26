//
//  KeyboardObserver.swift
//  Testio
//
//  Created by Nick Goncharenko on 26.11.2025.
//

import UIKit

final class KeyboardObserver {
    private var onShow: ((_ keyboardHeight: CGFloat) -> Void)?
    private var onHide: (() -> Void)?
    private weak var view: UIView!
    private let timeTravel: CGFloat = 0.25
    
    init(on view: UIView) {
        self.view = view
    }
    
    func startObserving(onShow: @escaping (_ keyboardHeight: CGFloat) -> Void, onHide: @escaping () -> Void) {
        self.onShow = onShow
        self.onHide = onHide
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func stopObserving() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let frameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = frameValue.cgRectValue
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: timeTravel) { [weak self] in
            guard let self = self else { return }
            self.onShow?(keyboardHeight)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: timeTravel) { [weak self] in
            guard let self = self else { return }
            self.onHide?()
            self.view.layoutIfNeeded()
        }
    }
}
