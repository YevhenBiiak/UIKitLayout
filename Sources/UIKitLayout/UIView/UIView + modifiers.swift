//
//  UIView + modifiers.swift
//
//  Created by Yevhen Biiak on 19.08.2023.
//

import UIKit
import AnchorLayout

extension UIView {
    
    @discardableResult
    public func subview(_ alignment: ViewAlignment, _ content: () -> UIView) -> Self {
        let view = content()
        addSubview(view)
        view.alignInSuperview(alignment)
        return self
    }
    
    @discardableResult
    public func backview(_ alignment: ViewAlignment, _ content: () -> UIView) -> Self {
        let view = content()
        insertSubview(view, at: 0)
        view.alignInSuperview(alignment)
        return self
    }
    
    @discardableResult
    public func padding(_ level: CGFloat? = nil) -> UIView {
        var spacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 16
        if let level { spacing = level }
        return padding(left: spacing, right: spacing, top: spacing, bottom: spacing)
    }
    
    @discardableResult
    public func padding(left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) -> UIView {
        removeConstraints([.top, .leading, .trailing, .bottom], to: .superview)
        let view = UIView()
        view.addSubview(self, tamic: false)
        topAnchor      == view.topAnchor + top
        leadingAnchor  == view.leadingAnchor + left
        trailingAnchor == view.trailingAnchor - right
        bottomAnchor   == view.bottomAnchor - bottom
        return view
    }
    
    @discardableResult
    public func frame(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        if let width {
            removeConstraints(.width)
            translatesAutoresizingMaskIntoConstraints = false
            widthAnchor == width
        }
        if let height {
            removeConstraints(.height)
            translatesAutoresizingMaskIntoConstraints = false
            heightAnchor == height
        }
        return self
    }
    
    @discardableResult
    public func frame(minWidth: CGFloat? = nil, minHeight: CGFloat? = nil) -> Self {
        if let minWidth {
            removeConstraints(.width)
            translatesAutoresizingMaskIntoConstraints = false
            widthAnchor >= minWidth
        }
        if let minHeight {
            removeConstraints(.height)
            translatesAutoresizingMaskIntoConstraints = false
            heightAnchor >= minHeight
        }
        return self
    }
    
    @discardableResult
    public func aspectRatio(_ aspectRatio: CGFloat) -> Self {
        widthAnchor == heightAnchor * aspectRatio
        return self
    }
    
    @discardableResult
    public func huggingPriority(_ axis: NSLayoutConstraint.Axis, _ priority: UILayoutPriority) -> Self {
        setContentHuggingPriority(priority, for: axis)
        return self
    }
    
    @discardableResult
    public func compressionPriority(_ axis: NSLayoutConstraint.Axis, _ priority: UILayoutPriority) -> Self {
        setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
    
    @discardableResult
    public func huggingPriority(_ axis: NSLayoutConstraint.Axis, _ priority: Float) -> Self {
        setContentHuggingPriority(.init(priority), for: axis)
        return self
    }
    
    @discardableResult
    public func compressionPriority(_ axis: NSLayoutConstraint.Axis, _ priority: Float) -> Self {
        setContentCompressionResistancePriority(.init(priority), for: axis)
        return self
    }
    
    @discardableResult
    public func hidden(_ isHidden: Bool, duration: TimeInterval = 0) -> Self {
        if duration == .zero {
            self.isHidden = isHidden
        } else {
            if self.isHidden != isHidden {
                if isHidden {
                    UIView.animate(withDuration: duration) {
                        self.alpha = 0
                    } completion: { _ in
                        self.isHidden = true
                        self.alpha = 1
                    }
                } else {
                    self.alpha = 0
                    self.isHidden = false
                    UIView.animate(withDuration: duration) {
                        self.alpha = 1
                    }
                }
            }
        }
        return self
    }
    
    @discardableResult
    public func contentMode(_ mode: UIView.ContentMode) -> Self {
        self.contentMode = mode
        return self
    }
}
