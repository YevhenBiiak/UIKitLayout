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
        static var validator = "_validator"
        static var editingEventsActionAdded = "_editingEventsActionAdded"
        static var validationUpdateHandler = "_validationUpdateHandler"
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
    
    /// called when one of editing event recieved
    public var validationUpdateHandler: ((_ validator: TextFieldValidator) -> Void)? {
        get { getAssociatedObject(key: &AssociatedKeys.validationUpdateHandler) }
        set { setAssociatedObject(key: &AssociatedKeys.validationUpdateHandler, value: newValue) }
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
            }
        }.store(in: self)
    }
}
