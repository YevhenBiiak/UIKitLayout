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
    
    public init(allowEmpty: Bool = false) {
        self.allowEmpty = allowEmpty
        super.init()
    }
    
    open override func validate(_ string: String?) -> Bool {
        if let string, !string.isEmpty {
            if let _ = Double(string) {
                return true
            } else {
                return false
            }
        } else {
            return allowEmpty
        }
    }
}
