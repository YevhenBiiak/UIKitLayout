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
    public func padding(_ level: CGFloat? = nil) -> UIView {
        var spacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 16
        if let level { spacing = level }
        return padding(left: spacing, right: spacing, top: spacing, bottom: spacing)
    }
    
    @discardableResult
    public func offset(x: CGFloat, y: CGFloat) -> UIView {
        return padding(left: x, right: -x, top: y, bottom: -y)
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
    
    // Actions
    
    @discardableResult
    public func onTapGesture(_ perform: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        tapGestureAction = perform
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecieved)))
        return self
    }
    
    @discardableResult
    public func onLongPress(_ perform: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        longPressAction = perform
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(lognPressRecieved)))
        return self
    }
    
    @discardableResult
    public func onTapGesture(_ perform: @escaping (_ view: UIView) -> Void) -> Self {
        isUserInteractionEnabled = true
        tapGestureHandler = perform
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecieved)))
        return self
    }
    
    @discardableResult
    public func onLongPress(_ perform: @escaping (_ view: UIView) -> Void) -> Self {
        isUserInteractionEnabled = true
        longPressHandler = perform
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(lognPressRecieved)))
        return self
    }
    
    @discardableResult
    public func hideKeyboardOnTap(force: Bool = false) -> Self {
        let tap: UITapGestureRecognizer = .init(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = !force
        self.addGestureRecognizer(tap)
        return self
    }
    
    @objc internal func tapGestureRecieved() {
        tapGestureAction?()
        tapGestureHandler?(self)
    }
    
    @objc internal func lognPressRecieved(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        longPressAction?()
        longPressHandler?(self)
    }
    
    @objc internal func dismissKeyboard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    // Appearance
    
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ hex: Int) -> Self {
        backgroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ hex: String) -> Self {
        backgroundColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func tintColor(_ color: UIColor) -> Self {
        tintColor = color
        return self
    }
    
    @discardableResult
    public func tintColor(_ hex: Int) -> Self {
        tintColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func tintColor(_ hex: String) -> Self {
        tintColor = UIColor(hex: hex)
        return self
    }
    
    @discardableResult
    public func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    public func clipsToBounds(_ flag: Bool) -> Self {
        clipsToBounds = flag
        return self
    }
    
    @discardableResult
    public func contentMode(_ mode: UIView.ContentMode) -> Self {
        self.contentMode = mode
        return self
    }
    
    @discardableResult
    public func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    public func blur(_ style: UIBlurEffect.Style = .systemMaterial, intensity: CGFloat = 1.0) -> Self {
        let blurredView = VisualEffectView(style: style, intensity: intensity)
        insertSubview(blurredView, at: 0, tamic: false)
        blurredView.edgeAnchors == edgeAnchors
        return self
    }
    
    @discardableResult
    public func shadow(color: UIColor = .black, radius: CGFloat = 5, x: CGFloat = 0, y: CGFloat = 6, opacity: Float = 0.5) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = .init(width: x, height: y)
        layer.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    public func border(_ edge: UIRectEdge, color: UIColor, width: CGFloat = 1) -> Self {
        let border = UIView()
        border.backgroundColor = color
        addSubview(border, tamic: false)
        
        switch edge {
        case .all:
            self.border(color, width: width)
        case .top:
            border.leftAnchor == leftAnchor
            border.topAnchor == topAnchor
            border.rightAnchor == rightAnchor
            border.bottomAnchor == topAnchor + width
        case .left:
            border.leftAnchor == leftAnchor
            border.topAnchor == topAnchor
            border.rightAnchor == leftAnchor + width
            border.bottomAnchor == bottomAnchor
        case .right:
            border.leftAnchor == rightAnchor - width
            border.topAnchor == topAnchor
            border.rightAnchor == rightAnchor
            border.bottomAnchor == bottomAnchor
        case .bottom:
            border.leftAnchor == leftAnchor
            border.topAnchor == bottomAnchor - width
            border.rightAnchor == rightAnchor
            border.bottomAnchor == bottomAnchor
        default:
            break
        }
        return self
    }
    
    @discardableResult
    public func border(_ color: UIColor, cornerRadius: CGFloat? = nil, width: CGFloat = 1) -> Self {
        if let cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        layer.borderColor = color.cgColor
        layer.borderWidth = width
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
}