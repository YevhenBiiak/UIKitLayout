//
//  UIView + modifiers.swift
//
//  Created by Yevhen Biiak on 19.08.2023.
//

import UIKit

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
    
    // MARK: Frame modifiers
    
    @discardableResult
    public func frame(width: CGFloat) -> Self {
        removeConstraints(.width)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor == width
        return self
    }
    
    @discardableResult
    public func frame(height: CGFloat) -> Self {
        removeConstraints(.height)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor == height
        return self
    }
    
    @discardableResult
    public func frame(width: CGFloat, height: CGFloat) -> Self {
        removeConstraints([.width, .height])
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor == width
        heightAnchor == height
        return self
    }
    
    @discardableResult
    public func frame(aspectRatio: CGFloat) -> Self {
        removeConstraints(.aspectRatio)
        widthAnchor == heightAnchor * aspectRatio
        return self
    }
    
    @discardableResult
    public func frame(width: PostfixPercentage) -> Self {
        if let superview {
            removeConstraints(.width, to: .superview)
            translatesAutoresizingMaskIntoConstraints = false
            widthAnchor == superview.widthAnchor * width.value
        } else {
            widthPercentage = width
            /* will be setted later in alignInSuperview(_:) */
        }
        return self
    }
    
    @discardableResult
    public func frame(height: PostfixPercentage) -> Self {
        if let superview {
            removeConstraints(.height, to: .superview)
            translatesAutoresizingMaskIntoConstraints = false
            heightAnchor == superview.heightAnchor * height.value
        } else {
            heightPercentage = height
            /* will be setted later in alignInSuperview(_:) */
        }
        return self
    }
    
    @discardableResult
    public func frame(width: PostfixPercentage, height: PostfixPercentage) -> Self {
        if let superview {
            removeConstraints([.width, .height], to: .superview)
            translatesAutoresizingMaskIntoConstraints = false
            widthAnchor == superview.widthAnchor * width.value
            heightAnchor == superview.heightAnchor * height.value
        } else {
            widthPercentage = width
            heightPercentage = height
            /* will be setted later in alignInSuperview(_:) */
        }
        return self
    }
    
    @discardableResult
    public func frame(width: CGFloat, height: PostfixPercentage) -> Self {
        removeConstraints(.width)
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor == width
        if let superview {
            removeConstraints(.height, to: .superview)
            heightAnchor == superview.heightAnchor * height.value
        } else {
            heightPercentage = height
            /* will be setted later in alignInSuperview(_:) */
        }
        return self
    }
    
    @discardableResult
    public func frame(width: PostfixPercentage, height: CGFloat) -> Self {
        removeConstraints(.height)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor == height
        if let superview {
            removeConstraints(.width, to: .superview)
            widthAnchor == superview.widthAnchor * width.value
        } else {
            widthPercentage = width
            /* will be setted later in alignInSuperview(_:) */
        }
        return self
    }
    
    @discardableResult
    @available(*, deprecated, message: "Might cause unexpected results")
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
    @available(*, deprecated, renamed: "frame(aspectRatio:)")
    public func aspectRatio(_ aspectRatio: CGFloat) -> Self {
        removeConstraints(.aspectRatio)
        widthAnchor == heightAnchor * aspectRatio
        return self
    }
    
    public func padding(left: CGFloat = 0, right: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) -> UIView {
        removeConstraints([.top, .leading, .trailing, .bottom], to: .superview)
        let view = UIView()
        view.widthPercentage = widthPercentage
        view.heightPercentage = heightPercentage
        view.addSubview(self, tamic: false)
        topAnchor      == view.topAnchor + top
        leadingAnchor  == view.leadingAnchor + left
        trailingAnchor == view.trailingAnchor - right
        bottomAnchor   == view.bottomAnchor - bottom
        return view
    }
    
    public func padding(_ level: CGFloat? = nil) -> UIView {
        var spacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 16
        if let level { spacing = level }
        return padding(left: spacing, right: spacing, top: spacing, bottom: spacing)
    }
    
    @available(*, deprecated, renamed: "padding(_:_:)")
    public func padding(_ axis: NSLayoutConstraint.Axis, length: CGFloat) -> UIView {
        switch axis {
        case .horizontal:
            return padding(left: length, right: length, top: 0, bottom: 0)
        case .vertical:
            return padding(left: 0, right: 0, top: length, bottom: length)
        @unknown default:
            return padding()
        }
    }
    
    public func padding(_ axis: NSLayoutConstraint.Axis, _ length: CGFloat) -> UIView {
        switch axis {
        case .horizontal:
            return padding(left: length, right: length, top: 0, bottom: 0)
        case .vertical:
            return padding(left: 0, right: 0, top: length, bottom: length)
        @unknown default:
            return padding()
        }
    }
    
    public func offset(x: CGFloat, y: CGFloat) -> UIView {
        return padding(left: x, right: -x, top: y, bottom: -y)
    }
    
    public func offset(x: CGFloat) -> UIView {
        return offset(x: x, y: 0)
    }
    
    public func offset(y: CGFloat) -> UIView {
        return offset(x: 0, y: y)
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
    
    // MARK: Actions modifiers
    
    @discardableResult
    public func onTapGesture(_ perform: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        tapGestureActions.append(perform)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecieved)))
        return self
    }
    
    @discardableResult
    public func onLongPress(_ perform: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        longPressActions.append(perform)
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(lognPressRecieved)))
        return self
    }
    
    @discardableResult
    public func onTapGesture(_ perform: @escaping (_ view: UIView) -> Void) -> Self {
        isUserInteractionEnabled = true
        tapGestureHandlers.append(perform)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecieved)))
        return self
    }
    
    @discardableResult
    public func onLongPress(_ perform: @escaping (_ view: UIView) -> Void) -> Self {
        isUserInteractionEnabled = true
        longPressHandlers.append(perform)
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
        tapGestureActions.forEach { $0() }
        tapGestureHandlers.forEach { $0(self) }
    }
    
    @objc internal func lognPressRecieved(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        longPressActions.forEach { $0() }
        longPressHandlers.forEach { $0(self) }
    }
    
    @objc internal func dismissKeyboard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    // MARK: Appearance modifiers
    
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
    public func clipsToBounds(_ enabled: Bool) -> Self {
        clipsToBounds = enabled
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
    public func userInteractionEnabled(_ enabled: Bool) -> Self {
        isUserInteractionEnabled = enabled
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
