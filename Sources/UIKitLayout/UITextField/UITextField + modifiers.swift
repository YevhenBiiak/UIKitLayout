//
//  UITextField + modifiers.swift
//
//  Created by Yevhen Biiak on 20.08.2023.
//

import UIKit
import Combine

extension UITextField {
    
    @discardableResult
    public func assignText(to publisher: inout Published<String>.Publisher) -> Self {
        self.editingEventsPublisher.assign(to: &publisher)
        return self
    }
    
    @discardableResult
    public func validator(_ validator: TextFieldValidator) -> Self {
        self.validator = validator
        self.keyboardType = validator.keyboardType
        validator.setup(with: self)
        addTarget(self, action: #selector(validationEventReceived), for: [.editingChanged, .editingDidEnd, .editingDidEndOnExit])
        return self
    }
    
    @discardableResult
    public func delegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func textAlignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    @discardableResult
    public func placeholderColor(_ color: UIColor) -> Self {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [.foregroundColor: color])
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    public func keyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }
}

extension UITextField {
    @objc private func validationEventReceived() {
        guard let validator else { return }
        validationStatusHandler?(validator)
    }
}
