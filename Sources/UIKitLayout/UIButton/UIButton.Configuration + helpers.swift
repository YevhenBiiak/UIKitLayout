//
//  UIButton.Configuration + helpers.swift
//
//  Created by Yevhen Biiak on 24.09.2023.
//

import UIKit

extension UIButton.Configuration {
    
    /// Sets font to titleTextAttributesTransformer closure but always returns nil
    public var font: UIFont? {
        get { nil }
        set {
            titleTextAttributesTransformer = .init { incoming in
                var outgoing = incoming
                outgoing.font = newValue
                return outgoing
            }
        }
    }
    
    internal var defaultUpdateHandler: (UIButton) -> Void {
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
            
            if let image = button._iconImages[button.state.rawValue] {
                button.configuration?.image = image
            } else if let normalImage = button._iconImages[UIControl.State.normal.rawValue] {
                setAdaptiveImage(for: normalImage)
            } else {
                if let image = button.configuration?.image {
                    button._iconImages[UIControl.State.normal.rawValue] = image
                    setAdaptiveImage(for: image)
                }
            }
            
            updateStroke()
            
            func setAdaptiveImage(for image: UIImage) {
                let alpha = button.state == .disabled ? 0.3 : button.state == .highlighted ? 0.8 : 1.0
                button.configuration?.image = image.withAlphaComponent(alpha)
            }
            
            func updateStroke() {
                /// because it has a strokeColor, even if it is not defined erlear
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
