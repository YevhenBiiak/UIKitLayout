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
        validateConfiguration()
        configuration?.title = title
        return self
    }
    
    @discardableResult
    public func baseBackgroundColor(_ color: UIColor) -> Self {
        validateConfiguration()
        configuration?.baseBackgroundColor = color
        return self
    }
    
    @discardableResult
    public func baseBackgroundColor(_ hex: Int) -> Self {
        validateConfiguration()
        configuration?.baseBackgroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func baseBackgroundColor(_ hex: String) -> Self {
        validateConfiguration()
        configuration?.baseBackgroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func baseForegroundColor(_ color: UIColor) -> Self {
        validateConfiguration()
        configuration?.baseForegroundColor = color
        return self
    }
    
    @discardableResult
    public func baseForegroundColor(_ hex: Int) -> Self {
        validateConfiguration()
        configuration?.baseForegroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func baseForegroundColor(_ hex: String) -> Self {
        validateConfiguration()
        configuration?.baseForegroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        validateConfiguration()
        configuration?.font = font
        return self
    }
    
    @discardableResult
    public func titleAlignment(_ alignment: UIButton.Configuration.TitleAlignment) -> Self {
        validateConfiguration()
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
        validateConfiguration()
        configuration?.contentInsets = insets
        return self
    }
    
    @discardableResult
    public func cornerStyle(_ style: UIButton.Configuration.CornerStyle) -> Self {
        validateConfiguration()
        configuration?.cornerStyle = style
        return self
    }
    
    @discardableResult
    public func strokeStyle(_ color: UIColor, cornerRadius: CGFloat? = nil, width: CGFloat = 1) -> Self {
        validateConfiguration()
        if let cornerRadius {
            configuration?.background.cornerRadius = cornerRadius
        }
        configuration?.background.strokeColor = color
        configuration?.background.strokeWidth = width
        return self
    }
    
    @discardableResult
    public func image(_ image: UIImage) -> Self {
        validateConfiguration()
        configuration?.image = image
        return self
    }
    
    @discardableResult
    public func imagePlacement(_ placement: NSDirectionalRectEdge) -> Self {
        validateConfiguration()
        configuration?.imagePlacement = placement
        return self
    }
    
    @discardableResult
    public func imagePadding(_ padding: CGFloat) -> Self {
        validateConfiguration()
        configuration?.imagePadding = padding
        return self
    }
}


extension UIButton {
    private func validateConfiguration() {
        if configuration == nil {
            configuration = .filled()
        }
    }
}
