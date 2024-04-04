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
    
    @discardableResult
    public func contentInsets(_ inset: CGFloat) -> Self {
        contentInset = .init(top: inset, left: inset, bottom: inset, right: inset)
        return self
    }
    
    @discardableResult
    public func contentInsets(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        if top == nil, left == nil, bottom == nil, right == nil {
            let inset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 16
            contentInset = .init(top: inset, left: inset, bottom: inset, right: inset)
            return self
        } else {
            if let top { contentInset.top = top }
            if let left { contentInset.left = left }
            if let bottom { contentInset.bottom = bottom }
            if let right { contentInset.right = right }
            return self
        }
    }
    
    @discardableResult
    public func contentInsets(_ axis: NSLayoutConstraint.Axis, _ inset: CGFloat) -> UIView {
        switch axis {
        case .horizontal:
            contentInset.left = inset
            contentInset.right = inset
        case .vertical:
            contentInset.top = inset
            contentInset.bottom = inset
        @unknown default:
            break
        }
        return self
    }
    
    @discardableResult
    public func contentInsetAdjustmentBehavior(_ behavior: ContentInsetAdjustmentBehavior) -> Self {
        contentInsetAdjustmentBehavior = behavior
        return self
    }
    
    @discardableResult
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
    
    @discardableResult
    public func scrollIndicators(_ visibility: UIVisibility, axis: NSLayoutConstraint.Axis) -> Self {
        scrollIndicators(visibility, axes: [axis])
    }
    
    @discardableResult
    @available(*, deprecated, renamed: "bouncesEnabled(_:)")
    public func bounces(_ enabled: Bool) -> Self {
        bounces = enabled
        return self
    }
    
    @discardableResult
    public func bouncesEnabled(_ enabled: Bool) -> Self {
        bounces = enabled
        return self
    }
    
    @discardableResult
    public func pagingEnabled(_ enabled: Bool) -> Self {
        isPagingEnabled = enabled
        return self
    }
    
    @discardableResult
    public func keyboardDismissMode(_ mode: KeyboardDismissMode) -> Self {
        keyboardDismissMode = mode
        return self
    }
}
