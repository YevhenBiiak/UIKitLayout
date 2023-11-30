//
//  UITextField.swift
//
//  Created by Yevhen Biiak on 20.08.2023.
//

import UIKit
import Combine

extension UITextField {
    
    private struct AssociatedKeys {
        // public
        static var validator = "validator"
        static var editingEventsActionAdded = "editingEventsActionAdded"
        static var errorLabel = "errorLabel"
        // private
    }
    
    internal var editingEventsActionAdded: Bool {
        get { getAssociatedObject(key: &AssociatedKeys.editingEventsActionAdded) ?? false }
        set { setAssociatedObject(key: &AssociatedKeys.editingEventsActionAdded, value: newValue) }
    }
    
    public internal(set) var validator: TextFieldValidator? {
        get { getAssociatedObject(key: &AssociatedKeys.validator) }
        set { setAssociatedObject(key: &AssociatedKeys.validator, value: newValue) }
    }
    
    public var errorLabel: UILabel? {
        get { getAssociatedObject(key: &AssociatedKeys.errorLabel) }
        set {
            errorLabel?.removeFromSuperview()
            setAssociatedObject(key: &AssociatedKeys.errorLabel, value: newValue)
        }
    }
    
    public convenience init(text: String) {
        self.init(frame: .zero)
        self.text = text
    }
    
    public convenience init(_ placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
    }
    
    public convenience init(_ placeholder: String, text: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.text = text
    }
    
    public convenience init(_ placeholder: String, text publisher: inout Published<String>.Publisher) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.assignText(to: &publisher)
    
        publisher.sink { [weak self] text in
            if self?.text != text {
                self?.text = text
                self?.validator?.validate()
            }
        }.store(in: self)
    }
}
