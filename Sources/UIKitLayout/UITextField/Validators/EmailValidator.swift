//
//  EmailValidator.swift
//
//  Created by Yevhen Biiak on 22.06.2023.
//

import UIKit

internal class EmailValidator: TextFieldValidator {
    
    private var allowEmpty: Bool
    
    public override var keyboardType: UIKeyboardType {
        .emailAddress
    }
    
    public init(allowEmpty: Bool = false) {
        self.allowEmpty = allowEmpty
        super.init()
    }
    
    open override func validate(_ string: String?) -> Bool {
        if let string, !string.isEmpty {
            let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let test = NSPredicate(format: "SELF MATCHES %@", pattern)
            let isValid = test.evaluate(with: string)
            return isValid
        } else {
            return allowEmpty
        }
    }
}
