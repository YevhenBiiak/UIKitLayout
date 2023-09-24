//
//  DoubleValidator.swift
//
//  Created by Yevhen Biiak on 26.06.2023.
//

import UIKit

open class DoubleValidator: TextFieldValidator {
    
    public override var keyboardType: UIKeyboardType {
        return .numbersAndPunctuation
    }
    
    open override func validate(_ string: String?) -> Bool {
        if let string, let _ = Double(string) {
            successHandler?()
            return true
        } else {
            failureHandler?()
            return false
        }
    }
}
