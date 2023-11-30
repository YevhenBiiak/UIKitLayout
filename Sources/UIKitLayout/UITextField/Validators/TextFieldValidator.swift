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
    
    public init(error: String) {
        self.error = error
    }
    
    open func isValid(_ string: String?) -> Bool {
        return true
    }
    
    @discardableResult
    public func validate() -> Bool {
        if let validation {
            return validation(self)
        } else {
            return true
        }
    }
    
    internal func setup(_ validation: ((TextFieldValidator) -> Bool)?, onSuccess: (() -> Void)?, onFailure: (() -> Void)?) {
        self.validation = validation
        self.successHandler = onSuccess
        self.failureHandler = onFailure
    }
}
