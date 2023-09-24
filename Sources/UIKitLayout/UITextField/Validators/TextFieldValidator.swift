//
//  TextFieldValidator.swift
//
//  Created by Yevhen Biiak on 20.08.2023.
//

import UIKit

open class TextFieldValidator {
    
    public var error: String
    public var keyboardType: UIKeyboardType { .default }
    
    internal var validation: ((TextFieldValidator) -> Bool)?
    internal var successHandler: (() -> Void)?
    internal var failureHandler: (() -> Void)?
    
    init(error: String) {
        self.error = error
    }
    
    @discardableResult
    public func isValid() -> Bool {
        if let validation {
            return validation(self)
        } else {
            return true
        }
    }
    
    @discardableResult
    open func validate(_ string: String?) -> Bool {
        return true
    }
    
    internal func setup(_ validation: ((TextFieldValidator) -> Bool)?, onSuccess: (() -> Void)?, onFailure: (() -> Void)?) {
        self.validation = validation
        self.successHandler = onSuccess
        self.failureHandler = onFailure
    }
}
