//
//  NSLayoutCenterAnchor.swift
//
//  Created by Yevhen Biiak on 09.09.2023.
//

import UIKit

public struct NSLayoutCenterAnchor {
    var centerXAnchor: NSLayoutXAxisAnchor
    var centerYAnchor: NSLayoutYAxisAnchor
}

extension UIView {
    public var centerAnchor: NSLayoutCenterAnchor {
        NSLayoutCenterAnchor(
            centerXAnchor: centerXAnchor,
            centerYAnchor: centerYAnchor
        )
    }
}

extension NSLayoutCenterAnchor {
    public static func == (lhs: NSLayoutCenterAnchor, rhs: NSLayoutCenterAnchor) {
        lhs.centerXAnchor == rhs.centerXAnchor
        lhs.centerYAnchor == rhs.centerYAnchor
    }
}
