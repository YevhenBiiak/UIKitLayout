//
//  UISearchBar + modifiers.swift
//  UIKitLayoutPlayground
//
//  Created by Yevhen Biiak on 17.09.2023.
//

import UIKit

extension UISearchBar {
    
    @discardableResult
    public func backgroundImage(_ image: UIImage) -> Self {
        backgroundImage = image
        return self
    }
    
    @discardableResult
    public func textFieldBackgroundColor(_ color: UIColor) -> Self {
        searchTextField.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func clearButtonMode(_ mode: UITextField.ViewMode) -> Self {
        searchTextField.clearButtonMode = mode
        return self
    }
    
    @discardableResult
    public func searchBarStyle(_ style: UISearchBar.Style ) -> Self {
        searchBarStyle = style
        return self
    }

    @discardableResult
    public func textFieldFont(_ font: UIFont) -> Self {
        searchTextField.font = font
        return self
    }
    
    @discardableResult
    public func image(_ image: UIImage?, for icon: Icon, state: UIControl.State = .normal) -> Self {
        setImage(image, for: icon, state: state)
        return self
    }
    
    @discardableResult
    public func delegate(_ delegate: UISearchBarDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func placeholder(_ text: String, attributes: [NSAttributedString.Key : Any] = [:]) -> Self {
        if attributes.isEmpty {
            placeholder = text
        } else {
            searchTextField.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
        }
        return self
    }
}
