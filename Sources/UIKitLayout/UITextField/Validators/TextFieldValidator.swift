//
//  TextFieldValidator.swift
//
//  Created by Yevhen Biiak on 20.08.2023.
//

import UIKit

open class TextFieldValidator {
    
    public var keyboardType: UIKeyboardType { .default }
    
    private var validation: ((TextFieldValidator) -> Bool)?
    
    public var isValid: Bool {
        if let validation {
            return validation(self)
        } else {
            return true
        }
    }
    
    open func validate(_ string: String?) -> Bool {
        return true
    }
    
    internal func setup(with textField: UITextField) {
        validation = { [weak textField] validator in
            validator.validate(textField?.text)
        }
    }
}
