//
//  UISlider + modifiers.swift
//
//  Created by Yevhen Biiak on 25.11.2023.
//

import UIKit

extension UISlider {
    
    public func minimumValue(_ value: Float) -> Self {
        minimumValue = value
        return self
    }
    
    public func maximumValue(_ value: Float) -> Self {
        maximumValue = value
        return self
    }
    
    public func minimumValueImage(_ image: UIImage?) -> Self {
        minimumValueImage = image
        return self
    }
    
    public func maximumValueImage(_ image: UIImage?) -> Self {
        maximumValueImage = image
        return self
    }
    
    public func minimumTrackTintColor(_ color: UIColor?) -> Self {
        minimumTrackTintColor = color
        return self
    }
    
    public func maximumTrackTintColor(_ color: UIColor?) -> Self {
        maximumTrackTintColor = color
        return self
    }
    
    public func thumbTintColor(_ color: UIColor?) -> Self {
        thumbTintColor = color
        return self
    }
}
