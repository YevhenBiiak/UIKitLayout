//
//  EmptyValidator.swift
//
//  Created by Yevhen Biiak on 22.06.2023.
//

import UIKit

internal class EmptyValidator: TextFieldValidator {
    
    open override func validate(_ string: String?) -> Bool {
        if let string {
            let isValid = !string.trimmingCharacters(in: .whitespaces).isEmpty
            return isValid
        } else {
            return false
        }
    }
}
