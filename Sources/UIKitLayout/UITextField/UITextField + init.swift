//
//  UITextField.swift
//
//  Created by Yevhen Biiak on 20.08.2023.
//

import UIKit
import Combine

extension UITextField {
    
    private struct UKLAssociatedKeys {
        static var _ukl_text_field_validator        = "_ukl_text_field_validator"
        static var _ukl_editing_events_action_added = "_ukl_editing_events_action_added"
        static var _ukl_validation_update_handler   = "_ukl_validation_update_handler"
    }
    
    internal var editingEventsActionAdded: Bool {
        get { getAssociatedObject(key: &UKLAssociatedKeys._ukl_editing_events_action_added) ?? false }
        set { setAssociatedObject(key: &UKLAssociatedKeys._ukl_editing_events_action_added, value: newValue) }
    }
    
    public internal(set) var validator: TextFieldValidator? {
        get { getAssociatedObject(key: &UKLAssociatedKeys._ukl_text_field_validator) }
        set { setAssociatedObject(key: &UKLAssociatedKeys._ukl_text_field_validator, value: newValue) }
    }
    
    /// called when one of editing event recieved
    public var validationUpdateHandler: ((_ validator: TextFieldValidator) -> Void)? {
        get { getAssociatedObject(key: &UKLAssociatedKeys._ukl_validation_update_handler) }
        set { setAssociatedObject(key: &UKLAssociatedKeys._ukl_validation_update_handler, value: newValue) }
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
    
    @available(iOS 14.0, *)
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
