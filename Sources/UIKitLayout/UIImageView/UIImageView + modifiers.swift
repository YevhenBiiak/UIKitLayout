//
//  UIImageView + modifiers.swift
//  Playground
//
//  Created by Yevhen Biiak on 21.08.2023.
//

import UIKit

extension UIImageView {
    
    @discardableResult
    public func image(_ image: UIImage?) -> Self {
        self.image = image
        return self
    }
}
