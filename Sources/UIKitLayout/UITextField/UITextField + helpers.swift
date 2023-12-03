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
    public static func empty() -> TextFieldValidator {
        EmptyValidator()
    }
    public static func double(allowEmpty: Bool = false) -> TextFieldValidator {
        DoubleValidator(allowEmpty: allowEmpty)
    }
    public static func email(allowEmpty: Bool = false) -> TextFieldValidator {
        EmailValidator(allowEmpty: allowEmpty)
    }
    public static func phone(allowEmpty: Bool = false) -> TextFieldValidator {
        PhoneValidator(allowEmpty: allowEmpty)
    }
    public static func website(allowEmpty: Bool = false) -> TextFieldValidator {
        WebsiteValidator(allowEmpty: allowEmpty)
    }
}
