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
        configurationUpdateHandler = defaultUpdateHandler
        configurationUpdateHandler?(self)
        return self
    }
    
    @discardableResult
    public func foregroundColor(_ color: UIColor, for state: UIControl.State) -> Self {
        validateConfiguration()
        _foregroundColors[state.rawValue] = color
        configurationUpdateHandler = defaultUpdateHandler
        configurationUpdateHandler?(self)
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
    
    private var defaultUpdateHandler: (UIButton) -> Void {
        { button in
            
            if let bgColor = button._backgroundColors[button.state.rawValue] {
                button.configuration?.background.backgroundColor = bgColor
            } else if let normalBGColor = button._backgroundColors[UIControl.State.normal.rawValue] {
                setAdaptiveBackgroundColor(for: normalBGColor)
            } else if let baseBGColor = button.configuration?.baseBackgroundColor {
                setAdaptiveBackgroundColor(for: baseBGColor)
            } else {
                setAdaptiveBackgroundColor(for: .systemBlue)
            }
            
            if let fgColor = button._foregroundColors[button.state.rawValue] {
                button.configuration?.attributedTitle = attributedTitle(withColor: fgColor)
            } else if let normalFGColor = button._foregroundColors[UIControl.State.normal.rawValue] {
                setAdaptiveForegroundColor(for: normalFGColor)
            } else if let baseFGColor = button.configuration?.baseForegroundColor {
                setAdaptiveForegroundColor(for: baseFGColor)
            } else {
                setAdaptiveForegroundColor(for: .white)
            }
            
            updateIcon()
            updateStroke()
            
            func updateIcon() {
                let alpha = button.state == .disabled ? 0.3 : button.state == .highlighted ? 0.8 : 1.0
                button.configuration?.image = button.configuration?.image?.withTintColor(.black.withAlphaComponent(alpha))
            }
            func updateStroke() {
                /// because it has a stroleColor, even if it is not defined erlear
                guard button._isStrokeColorAdded else { return }
                let color = button.configuration?.background.strokeColor
                guard color != .clear else { return }
                let alpha = button.state == .disabled ? 0.3 : button.state == .highlighted ? 0.8 : 1.0
                button.configuration?.background.strokeColor = color?.withAlphaComponent(alpha)
            }
            
            func setAdaptiveBackgroundColor(for color: UIColor) {
                guard color != .clear else { return }
                let alpha = button.state == .disabled ? 0.5 : button.state == .highlighted ? 0.8 : 1.0
                button.configuration?.background.backgroundColor = color.withAlphaComponent(alpha)
            }
            
            func setAdaptiveForegroundColor(for color: UIColor) {
                guard color != .clear else { return }
                let alpha = button.state == .disabled ? 0.5 : button.state == .highlighted ? 0.8 : 1.0
                button.configuration?.attributedTitle = attributedTitle(withColor: color.withAlphaComponent(alpha))
            }
            
            func attributedTitle(withColor color: UIColor) -> AttributedString {
                AttributedString(NSAttributedString(
                    string: button.configuration?.title ?? "",
                    attributes: [.foregroundColor: color]
                ))
            }
        }
    }
}
