//
//  PhoneValidator.swift
//
//  Created by Yevhen Biiak on 14.07.2023.
//

import UIKit

open class PhoneValidator: TextFieldValidator {
    
    public var allowEmpty: Bool
    
    public override var keyboardType: UIKeyboardType {
        .phonePad
    }
    
    init(error: String, allowEmpty: Bool) {
        self.allowEmpty = allowEmpty
        super.init(error: error)
    }
    
    open override func validate(_ string: String?) -> Bool {
        if let string, !string.isEmpty {
            let isValid = string.validPhoneNumber
            isValid ? successHandler?() : failureHandler?()
            return isValid
        } else {
            allowEmpty ? successHandler?() : failureHandler?()
            return allowEmpty ? true : false
        }
    }
}

private extension String {
    var validPhoneNumber: Bool {
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count)).first?.phoneNumber {
            return match == self
        } else {
            return false
        }
    }
}
