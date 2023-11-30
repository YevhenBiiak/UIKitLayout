//
//  DoubleValidator.swift
//
//  Created by Yevhen Biiak on 26.06.2023.
//

import UIKit

internal class DoubleValidator: TextFieldValidator {
    
    private var allowEmpty: Bool
    
    public override var keyboardType: UIKeyboardType {
        .numbersAndPunctuation
    }
    
    public init(error: String, allowEmpty: Bool = false) {
        self.allowEmpty = allowEmpty
        super.init(error: error)
    }
    
    open override func isValid(_ string: String?) -> Bool {
        if let string, !string.isEmpty {
            if let _ = Double(string) {
                successHandler?()
                return true
            } else {
                failureHandler?()
                return false
            }
        } else {
            allowEmpty ? successHandler?() : failureHandler?()
            return allowEmpty
        }
    }
}
