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
    public func frame(width: UKLPostfixPercentage) -> Self {
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
    public func frame(height: UKLPostfixPercentage) -> Self {
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
    public func frame(width: UKLPostfixPercentage, height: UKLPostfixPercentage) -> Self {
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
    public func frame(width: CGFloat, height: UKLPostfixPercentage) -> Self {
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
    public func frame(width: UKLPostfixPercentage, height: CGFloat) -> Self {
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
    public func onTapGesture(force: Bool = false, _ perform: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        onTapGesture(force: force, {_ in perform()})
        return self
    }
    
    @discardableResult
    public func onTapGesture(force: Bool = false, _ perform: @escaping (_ gesture: UITapGestureRecognizer) -> Void) -> Self {
        isUserInteractionEnabled = true
        tapGestureHandler = perform
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecieved))
        tap.cancelsTouchesInView = !force
        addGestureRecognizer(tap)
        return self
    }
    
    @discardableResult
    public func onLongPress(duration: TimeInterval? = nil, force: Bool = false, _ perform: @escaping () -> Void) -> Self {
        onLongPress(duration: duration, force: force, {
            if $0.state == .began { perform() }
        })
        return self
    }
    
    @discardableResult
    public func onLongPress(duration: TimeInterval? = nil, force: Bool = false, _ perform: @escaping (_ gesture: UILongPressGestureRecognizer) -> Void) -> Self {
        isUserInteractionEnabled = true
        longPressHandler = perform
        let press = UILongPressGestureRecognizer(target: self, action: #selector(lognPressRecieved))
        if let duration {
            press.minimumPressDuration = duration
        }
        press.cancelsTouchesInView = !force
        addGestureRecognizer(press)
        return self
    }
    
    @objc internal func tapGestureRecieved(_ gesture: UITapGestureRecognizer) {
        tapGestureHandler?(gesture)
    }
    
    @objc internal func lognPressRecieved(_ gesture: UILongPressGestureRecognizer) {
        longPressHandler?(gesture)
    }
    
    @discardableResult
    public func hideKeyboardOnTap(force: Bool = false) -> Self {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = !force
        addGestureRecognizer(tap)
        return self
    }
    
    @objc internal func dismissKeyboard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.controller?.view.endEditing(true)
            // UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    // MARK: Appearance modifiers
    
    @discardableResult
    public func backgroundColor(_ color: UIColor) -> Self {
        if let button = self as? UIButton {
            button.backgroundColor(color, for: .normal)
        } else {
            backgroundColor = color
        }
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ hex: Int) -> Self {
        backgroundColor(UIColor(hex: hex))
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ hex: String) -> Self {
        backgroundColor(UIColor(hex: hex))
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
    public func blur(radius: CGFloat, color: UIColor? = nil) -> Self {
        let blurredView = UKLVisualEffectView(radius: radius)
        blurredView.backgroundColor = color
        insertSubview(blurredView, at: 0, tamic: false)
        blurredView.edgeAnchors == edgeAnchors
        return self
    }
    
    @discardableResult
    public func blur(style: UIBlurEffect.Style) -> Self {
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        insertSubview(blurredView, at: 0, tamic: false)
        blurredView.edgeAnchors == edgeAnchors
        return self
    }
    
    @discardableResult
    public func shadow(_ color: UIColor = .black, radius: CGFloat = 5, x: CGFloat = 0, y: CGFloat = 6, opacity: Float = 0.5) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = .init(width: x, height: y)
        layer.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    public func innerShadow(_ color: UIColor = .black, radius: CGFloat, x: CGFloat, y: CGFloat, opacity: Float = 0.2) -> Self {
        
        let block: (Any) -> Void = { [weak self] _ in
            guard let self else { return }
            let radius = radius < 0 ? 0 : radius
            
            _shadowLayer?.removeFromSuperlayer()
            
            let cornerRadius = layer.cornerRadius
            
            let path = UIBezierPath.fixedRoundedRect(rect: bounds.insetBy(dx: -abs(x), dy: -abs(y)), cornerRadius: cornerRadius)
            let cutout = UIBezierPath.fixedRoundedRect(rect: bounds, cornerRadius: cornerRadius).reversing()
            path.append(cutout)
            
            let innerShadow = CALayer()
            innerShadow.frame = bounds
            innerShadow.shadowPath = path.cgPath
            innerShadow.shadowColor = color.cgColor
            innerShadow.shadowOffset = CGSize(
                width:  x < 0 ? -(abs(x) - radius) : (abs(x) - radius),
                height: y < 0 ? -(abs(y) - radius) : (abs(y) - radius)
            )
            innerShadow.shadowOpacity = opacity
            innerShadow.shadowRadius = radius
            innerShadow.cornerRadius = cornerRadius
            innerShadow.masksToBounds = true
            layer.addSublayer(innerShadow)
            
            _shadowLayer = innerShadow
        }
        
        layer.onChange(\.bounds, block)
        layer.onChange(\.cornerRadius, block)
        
        return self
    }
    
    @discardableResult
    public func border(_ color: UIColor, edge: UIRectEdge, width: CGFloat = 1) -> Self {
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
    
    // @discardableResult
    // public func constraintInsets(_ insets: UIEdgeInsets) -> Self {
    //     _constraintInsets = insets
    //     return self
    // }
    // 
    // @discardableResult
    // public func constraintInsets(_ inset: CGFloat) -> Self {
    //     _constraintInsets = .init(top: inset, left: inset, bottom: inset, right: inset)
    //     return self
    // }
    // 
    // @discardableResult
    // public func constraintInsets(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
    //     if top == nil, left == nil, bottom == nil, right == nil {
    //         let inset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 16
    //         _constraintInsets = .init(top: inset, left: inset, bottom: inset, right: inset)
    //         return self
    //     } else {
    //         if let top { _constraintInsets.top = top }
    //         if let left { _constraintInsets.left = left }
    //         if let bottom { _constraintInsets.bottom = bottom }
    //         if let right { _constraintInsets.right = right }
    //         return self
    //     }
    // }
    // 
    // @discardableResult
    // public func constraintInsets(_ axis: NSLayoutConstraint.Axis, _ inset: CGFloat) -> UIView {
    //     switch axis {
    //     case .horizontal:
    //         _constraintInsets.left = inset
    //         _constraintInsets.right = inset
    //     case .vertical:
    //         _constraintInsets.top = inset
    //         _constraintInsets.bottom = inset
    //     @unknown default:
    //         break
    //     }
    //     return self
    // }
}
