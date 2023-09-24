//
//  UIScrollView + modifiers.swift
//
//  Created by Yevhen Biiak on 23.09.2023.
//

import UIKit

extension UIScrollView {
    
    @discardableResult
    public func contentInsets(_ insets: UIEdgeInsets) -> Self {
        contentInset = insets
        return self
    }
    
    @discardableResult
    public func contentInsets(_ edge: UIRectEdge, _ inset: CGFloat) -> Self {
        if edge.contains(.top) {
            contentInset.top = inset
        }
        if edge.contains(.left) {
            contentInset.left = inset
        }
        if edge.contains(.bottom) {
            contentInset.bottom = inset
        }
        if edge.contains(.right) {
            contentInset.right = inset
        }
        if edge.contains(.all) {
            contentInset = .init(top: inset, left: inset, bottom: inset, right: inset)
        }
        return self
    }
    
    public func scrollIndicators(_ visibility: UIVisibility, axes: [NSLayoutConstraint.Axis] = [.vertical, .horizontal]) -> Self {
        for axis in axes {
            switch axis {
            case .horizontal:
                switch visibility {
                case .hidden:  showsHorizontalScrollIndicator = false
                case .visible: showsHorizontalScrollIndicator = true }
            case .vertical:
                switch visibility {
                case .hidden:  showsVerticalScrollIndicator = false
                case .visible: showsVerticalScrollIndicator = true }
            @unknown default:
                break
            }
        }
        return self
    }
    
    public func scrollIndicators(_ visibility: UIVisibility, axis: NSLayoutConstraint.Axis) -> Self {
        return scrollIndicators(visibility, axes: [axis])
    }
}
