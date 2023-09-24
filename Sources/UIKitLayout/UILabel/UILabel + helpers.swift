//
//  UILabel + helpers.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit

extension UILabel {
    
    public func adjustFontSize(minScale: CGFloat) {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = minScale
    }
    
    public func textShadow(_ color: UIColor, offset: CGSize) {
        shadowColor = color
        shadowOffset = offset
    }
}
