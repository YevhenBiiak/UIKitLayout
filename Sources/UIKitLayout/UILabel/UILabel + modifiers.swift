//
//  Label.swift
//  Playground
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit

extension UILabel {
    
    @discardableResult
    public func text(_ string: String?) -> Self {
        text = string
        return self
    }
    
    @discardableResult
    public func numberOfLines(_ count: Int) -> Self {
        numberOfLines = count
        return self
    }
    
    @discardableResult
    public func textAlignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func lineBrakeMode(_ mode: NSLineBreakMode) -> Self {
        lineBreakMode = mode
        return self
    }
    
    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    public func adjustFontSize(minScale: CGFloat) -> Self {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = minScale
        return self
    }
    
    @discardableResult
    public func textShadow(_ color: UIColor, offset: CGSize) -> Self {
        shadowColor = color
        shadowOffset = offset
        return self
    }
}
