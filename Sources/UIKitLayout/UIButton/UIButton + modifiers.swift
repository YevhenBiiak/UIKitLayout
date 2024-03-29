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
    public func backgroundColor(_ color: UIColor, for state: UIControl.State) -> Self {
        validateConfiguration()
        _backgroundColors[state.rawValue] = color
        configurationUpdateHandler = configuration?.defaultUpdateHandler
        configurationUpdateHandler?(self)
        return self
    }
    
    @discardableResult
    public func foregroundColor(_ color: UIColor, for state: UIControl.State) -> Self {
        validateConfiguration()
        _foregroundColors[state.rawValue] = color
        configurationUpdateHandler = configuration?.defaultUpdateHandler
        configurationUpdateHandler?(self)
        return self
    }
    
    @discardableResult
    public func image(_ image: UIImage, for state: UIControl.State) -> Self {
        validateConfiguration()
        _iconImages[state.rawValue] = image
        configurationUpdateHandler = configuration?.defaultUpdateHandler
        configurationUpdateHandler?(self)
        return self
    }
    
    @discardableResult
    public func foregroundColor(_ color: UIColor) -> Self {
        foregroundColor(color, for: .normal)
        return self
    }
    
    @discardableResult
    public func image(_ image: UIImage) -> Self {
        validateConfiguration()
        configuration?.image = image
        _iconImages[UIButton.State.normal.rawValue] = image
        configurationUpdateHandler?(self)
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
    
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        validateConfiguration()
        configuration?.font = font
        return self
    }
    
    @discardableResult
    public func enabled(_ enabled: Bool) -> Self {
        isEnabled = enabled
        return self
    }
    
    @discardableResult
    public func adjustFontSize(minScale: CGFloat) -> Self {
        validateConfiguration()
        findAll(UILabel.self).forEach { $0.adjustFontSize(minScale: minScale) }
        return self
    }
    
    @discardableResult
    public func titleAlignment(_ alignment: UIButton.Configuration.TitleAlignment) -> Self {
        validateConfiguration()
        configuration?.titleAlignment = alignment
        return self
    }
    
    @discardableResult
    public func titleLineBrakeMode(_ mode: NSLineBreakMode) -> Self {
        validateConfiguration()
        configuration?.titleLineBreakMode = mode
        return self
    }
    
    @discardableResult
    public func subtitleLineBrakeMode(_ mode: NSLineBreakMode) -> Self {
        validateConfiguration()
        configuration?.subtitleLineBreakMode = mode
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
    @available(*, deprecated, renamed: "border(_:cornerRadius:width:)")
    public func strokeStyle(_ color: UIColor, cornerRadius: CGFloat? = nil, width: CGFloat = 1) -> Self {
        validateConfiguration()
        if let cornerRadius {
            configuration?.background.cornerRadius = cornerRadius
        }
        configuration?.background.strokeColor = color
        configuration?.background.strokeWidth = width
        _isStrokeColorAdded = true
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
