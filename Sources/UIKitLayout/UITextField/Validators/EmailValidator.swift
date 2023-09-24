//
//  EmailValidator.swift
//
//  Created by Yevhen Biiak on 22.06.2023.
//

import UIKit

open class EmailValidator: TextFieldValidator {
    
    public var allowEmpty: Bool
    
    public override var keyboardType: UIKeyboardType {
        return .emailAddress
    }
    
    init(error: String, allowEmpty: Bool) {
        self.allowEmpty = allowEmpty
        super.init(error: error)
    }
    
    open override func validate(_ string: String?) -> Bool {
        if let string, !string.isEmpty {
            let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let test = NSPredicate(format: "SELF MATCHES %@", pattern)
            let isValid = test.evaluate(with: string)
            isValid ? successHandler?() : failureHandler?()
            return isValid
        } else {
            allowEmpty ? successHandler?() : failureHandler?()
            return allowEmpty ? true : false
        }
    }
}
