//
//  UIStackView + extensions.swift
//
//  Created by Yevhen Biiak on 18.08.2023.
//

import UIKit

extension UIStackView {
    
    public func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
    
    public func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
