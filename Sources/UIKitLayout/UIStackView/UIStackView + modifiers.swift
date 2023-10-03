//
//  StackView + modifiers.swift
//
//  Created by Yevhen Biiak on 16.08.2023.
//

import UIKit

extension UIStackView {
    
    @discardableResult
    public func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }
    
    @discardableResult
    public func alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    @discardableResult
    public func distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }
    
    @discardableResult
    public func spacing(_ distance: CGFloat) -> Self {
        self.spacing = distance
        return self
    }
}
