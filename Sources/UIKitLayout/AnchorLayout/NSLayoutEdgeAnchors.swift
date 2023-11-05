//
//  NSLayoutEdgeAnchors.swift
//
//  Created by Yevhen Biiak on 09.09.2023.
//

import UIKit

public struct NSLayoutEdgeAnchors {
    var topAnchor: NSLayoutYAxisAnchor
    var leadingAnchor: NSLayoutXAxisAnchor
    var trailingAnchor: NSLayoutXAxisAnchor
    var bottomAnchor: NSLayoutYAxisAnchor
}

extension UIView {
    public var edgeAnchors: NSLayoutEdgeAnchors {
        NSLayoutEdgeAnchors(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            trailingAnchor: trailingAnchor,
            bottomAnchor: bottomAnchor
        )
    }
}

extension NSLayoutEdgeAnchors {
    public static func == (lhs: NSLayoutEdgeAnchors, rhs: NSLayoutEdgeAnchors) {
        lhs.topAnchor == rhs.topAnchor
        lhs.leadingAnchor == rhs.leadingAnchor
        lhs.trailingAnchor == rhs.trailingAnchor
        lhs.bottomAnchor == rhs.bottomAnchor
    }
}
