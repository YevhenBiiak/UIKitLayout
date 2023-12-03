//
//  WebsiteValidator.swift
//
//  Created by Yevhen Biiak on 14.07.2023.
//

import UIKit

internal class WebsiteValidator: TextFieldValidator {
    
    private var allowEmpty: Bool
    
    public override var keyboardType: UIKeyboardType {
        .URL
    }
    
    public init(allowEmpty: Bool = false) {
        self.allowEmpty = allowEmpty
        super.init()
    }
    
    open override func validate(_ string: String?) -> Bool {
        if let string, !string.isEmpty {
            let pattern = "^(https?://)?(www\\.)?([-a-zA-Z0-9]{1,63}\\.)*?[a-zA-Z0-9][-a-zA-Z0-9]{0,61}[a-zA-Z0-9]\\.[a-zA-Z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
            let test = NSPredicate(format: "SELF MATCHES %@", pattern)
            let isValid = test.evaluate(with: string)
            return isValid
        } else {
            return allowEmpty
        }
    }
}
