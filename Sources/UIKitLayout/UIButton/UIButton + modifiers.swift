//
//  UIButton + extensions.swift
//  Playground
//
//  Created by Yevhen Biiak on 18.08.2023.
//

import UIKit

extension UIButton {
    
    @discardableResult
    public func title(_ title: String) -> Self {
        configuration?.title = title
        return self
    }
    
    @discardableResult
    public func baseBackgroundColor(_ color: UIColor) -> Self {
        configuration?.baseBackgroundColor = color
        return self
    }
    
    @discardableResult
    public func baseBackgroundColor(_ hex: Int) -> Self {
        configuration?.baseBackgroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func baseBackgroundColor(_ hex: String) -> Self {
        configuration?.baseBackgroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func baseForegroundColor(_ color: UIColor) -> Self {
        configuration?.baseForegroundColor = color
        return self
    }
    
    @discardableResult
    public func baseForegroundColor(_ hex: Int) -> Self {
        configuration?.baseForegroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func baseForegroundColor(_ hex: String) -> Self {
        configuration?.baseForegroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        configuration?.font = font
        return self
    }
    
    @discardableResult
    public func titleAlignment(_ alignment: UIButton.Configuration.TitleAlignment) -> Self {
        configuration?.titleAlignment = alignment
        return self
    }
    
    @discardableResult
    public func contentAlignment(_ alignment: UIControl.ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        return self
    }
    
    @discardableResult
    public func contentAlignment(_ alignment: UIControl.ContentVerticalAlignment) -> Self {
        contentVerticalAlignment = alignment
        return self
    }
    
    @discardableResult
    public func contentInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
        configuration?.contentInsets = insets
        return self
    }
    
    @discardableResult
    public func cornerStyle(_ style: UIButton.Configuration.CornerStyle) -> Self {
        configuration?.cornerStyle = style
        return self
    }
    
    @discardableResult
    public func image(_ image: UIImage) -> Self {
        configuration?.image = image
        return self
    }
    
    @discardableResult
    public func imagePlacement(_ placement: NSDirectionalRectEdge) -> Self {
        configuration?.imagePlacement = placement
        return self
    }
    
    @discardableResult
    public func imagePadding(_ padding: CGFloat) -> Self {
        configuration?.imagePadding = padding
        return self
    }
}
