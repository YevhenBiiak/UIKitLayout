//
//  UITextField + helpers.swift
//
//  Created by Yevhen Biiak on 20.08.2023.
//

import UIKit
import Combine

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
                    textField.validator?.validate()
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
}

extension TextFieldValidator {
    public static func empty(error: String) -> TextFieldValidator {
        EmptyValidator(error: error)
    }
    public static func double(error: String, allowEmpty: Bool = false) -> TextFieldValidator {
        DoubleValidator(error: error, allowEmpty: allowEmpty)
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
