//
//  UITextField + helpers.swift
//
//  Created by Yevhen Biiak on 20.08.2023.
//

import UIKit
import Combine
import AnchorLayout

extension UITextField {
    
    internal var editingEventsPublisher: AnyPublisher<String, Never> {
        if !editingEventsActionAdded {
            editingEventsActionAdded = true
            addTarget(self, action: #selector(editingEventReceived), for: .allEditingEvents)
        }
        
        return NotificationCenter.default
            .publisher(for: Notification.Name("UITextField.allEditingEvents"), object: self)
            .compactMap { sender in
                if let textField = sender.object as? UITextField {
                    textField.validator?.validate(textField.text)
                    return textField.text ?? ""
                } else {
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
    
    @objc private func editingEventReceived() {
        NotificationCenter.default.post(name: Notification.Name("UITextField.allEditingEvents"), object: self)
    }
    
    public func onEvent(_ event: UIControl.Event, _ action: @escaping (inout String?) -> Void) {
        addAction(UIAction { _ in action(&self.text) }, for: event)
    }
    
    public func assignText(to publisher: inout Published<String>.Publisher) {
        editingEventsPublisher.assign(to: &publisher)
    }
    
    @discardableResult
    public func validator(_ validator: TextFieldValidator) -> TextFieldValidator {
        func addErrorLabel() {
            errorLabel = UILabel()
            errorLabel!.font = .systemFont(ofSize: 12)
            errorLabel!.textColor = .systemRed
            
            addSubview(errorLabel!, tamic: false)
            errorLabel!.topAnchor == bottomAnchor
            errorLabel!.leadingAnchor == leadingAnchor
            errorLabel!.trailingAnchor == trailingAnchor
        }
        
        addErrorLabel()
        self.validator = validator
        self.keyboardType = validator.keyboardType
        self.errorLabel?.text = validator.error
        
        self.validator?.setup { [weak self] validator in
            validator.validate(self?.text)
        } onSuccess: { [weak self] in
            self?.errorLabel?.isHidden = true
        } onFailure: { [weak self] in
            self?.errorLabel?.isHidden = false
        }
        
        return validator
    }
    
    public func placeholderColor(_ color: UIColor) {
        attributedPlaceholder = .init(string: placeholder ?? "",
                                      attributes: [.foregroundColor: color])
    }
}

extension TextFieldValidator {
    public static func empty(error: String) -> TextFieldValidator {
        EmptyValidator(error: error)
    }
    public static func double(error: String) -> TextFieldValidator {
        DoubleValidator(error: error)
    }
    public static func email(error: String, allowEmpty: Bool = false) -> TextFieldValidator {
        EmailValidator(error: error, allowEmpty: allowEmpty)
    }
    public static func phone(error: String, allowEmpty: Bool = false) -> TextFieldValidator {
        PhoneValidator(error: error, allowEmpty: allowEmpty)
    }
    public static func website(error: String, allowEmpty: Bool = false) -> TextFieldValidator {
        WebsiteValidator(error: error, allowEmpty: allowEmpty)
    }
}
