//
//  FormTextField.swift
//  Testio
//
//  Created by Nick Goncharenko on 27.11.2025.
//

import UIKit

final class FormTextField: UIStackView {
    
    enum TextFieldTagName: Int {
        case first = 0
        case last = 1
    }
    
    private var iconView: UIImageView
    private var textField: UITextField
    
    // MARK: - Initialier
    init(icon: UIImage?, placeholder: String) {
        self.iconView = Self.createIconView(with: icon)
        self.textField = Self.createTextField(with: placeholder)
        
        super.init(frame: .zero)
        
        textField.delegate(self)
        addArrangedSubviews([iconView, textField])
        distribution(.fill)
        axis(.horizontal)
        
        roundedCorners(.allCorners, radius: 10)
        background(color: R.color.fadedGraphite())
        clipsToBounds(true)
        edgeInsets(right: 9)
        
        snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        iconView.snp.makeConstraints { make in
            make.width.equalTo(34)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private creation methods
    private static func createIconView(with image: UIImage?) -> UIImageView {
        return UIImageView(image: image)
            .tint(color: R.color.carbonShadow()?.withAlphaComponent(0.6))
            .contentMode(.center)
    }
    
    private static func createTextField(with placeholder: String) -> UITextField {
        return UITextField()
            .placeholder(
                text: placeholder,
                font: R.font.sfProTextRegular(size: 18),
                color: R.color.carbonShadow()?.withAlphaComponent(0.6)
            )
            .tint(color: R.color.systemBlue())
            .text(color: R.color.carbonShadow())
            .text(font: R.font.sfProTextRegular(size: 18))
    }
    
    // MARK: - Internal getters
    internal var getText: String {
        textField.text ?? ""
    }
    
    // MARK: - Internal setters
    internal func keyboardType(_ value: UIKeyboardType) -> Self {
        textField.keyboardType(value)
        return self
    }
    
    internal func returnKeyType(_ value: UIReturnKeyType) -> Self {
        textField.returnKeyType(value)
        return self
    }
    
    internal func isSecureTextEntry(_ value: Bool) -> Self {
        textField.isSecureTextEntry(value)
        return self
    }
    
    internal func tagName(_ tagName: TextFieldTagName) -> Self {
        textField.tag(tagName.rawValue)
        return self
    }
}

// MARK: - TextFiled extensions
extension FormTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        iconView.tint(color: R.color.carbonShadow())
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        iconView.tint(color: R.color.carbonShadow()?.withAlphaComponent(0.6))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextField = superview?.viewWithTag(nextTag) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
