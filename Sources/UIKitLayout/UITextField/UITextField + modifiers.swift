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
        self.addErrorLabel()
        self.validator = validator
        self.keyboardType = validator.keyboardType
        self.errorLabel?.text = validator.error
        
        validator.setup { [weak self] validator in
            validator.isValid(self?.text)
        } onSuccess: { [weak self] in
            self?.hideErrorLabel()
        } onFailure: { [weak self] in
            self?.showErrorLabel()
        }
        
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
}

private extension UITextField {
    
    func addErrorLabel() {
        errorLabel = UILabel()
        errorLabel!.font = .systemFont(ofSize: 12)
        errorLabel!.textColor = .systemRed
        
        addSubview(errorLabel!, tamic: false)
        errorLabel!.topAnchor == bottomAnchor
        errorLabel!.leadingAnchor == leadingAnchor
        errorLabel!.trailingAnchor == trailingAnchor
    }
    
    func showErrorLabel() {
        errorLabel?.isHidden = false
    }
    
    func hideErrorLabel() {
        errorLabel?.isHidden = true
    }
}
