//
//  UISwitch + modifiers.swift
//  Playground
//
//  Created by Yevhen Biiak on 21.08.2023.
//

import UIKit

extension UISwitch {
    
    @discardableResult
    public func set(isOn: Bool, animated: Bool) -> Self {
        self.setOn(isOn, animated: animated)
        return self
    }
    
    @discardableResult
    public func preferredStyle(_ style: UISwitch.Style) -> Self {
        preferredStyle = style
        return self
    }
    
    @discardableResult
    public func title(_ title: String?) -> Self {
        self.title = title
        return self
    }
    
    @discardableResult
    public func onTintColor(_ color: UIColor?) -> Self {
        onTintColor = color
        return self
    }
    
    @discardableResult
    public func thumbTintColor(_ color: UIColor?) -> Self {
        thumbTintColor = color
        return self
    }
    
    @discardableResult
    public func onImage(_ image: UIImage?) -> Self {
        onImage = image
        return self
    }
    
    @discardableResult
    public func offImage(_ image: UIImage?) -> Self {
        offImage = image
        return self
    }
}
