//
//  UIActivityIndicatorView + modifiers.swift
//
//  Created by Yevhen Biiak on 09.11.2023.
//

import UIKit

extension UIActivityIndicatorView {
    
    @discardableResult
    public func indicatorStyle(_ style: UIActivityIndicatorView.Style) -> Self {
        self.style = style
        return self
    }
    
    @discardableResult
    public func hidesWhenStopped(_ enabled: Bool) -> Self {
        self.hidesWhenStopped = enabled
        return self
    }
    
    @discardableResult
    public func indicatorColor(_ color: UIColor) -> Self {
        self.color = color
        return self
    }
}
