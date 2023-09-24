//
//  UIView + helpers.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit
import AnchorLayout

extension UIView {
    
    // Actions
    
    public func addTapGesture(_ perform: @escaping () -> Void) {
        isUserInteractionEnabled = true
        tapGestureAction = perform
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecieved)))
    }
    
    public func addLongPress(_ perform: @escaping () -> Void) {
        isUserInteractionEnabled = true
        longPressAction = perform
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(lognPressRecieved)))
    }
    
    public func addTapGesture(_ perform: @escaping (_ view: UIView) -> Void) {
        isUserInteractionEnabled = true
        tapGestureHandler = perform
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureRecieved)))
    }
    
    public func addLongPress(_ perform: @escaping (_ view: UIView) -> Void) {
        isUserInteractionEnabled = true
        longPressHandler = perform
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(lognPressRecieved)))
    }
    
    public func hideKeyboardOnTap(force: Bool = false) {
        let tap: UITapGestureRecognizer = .init(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = !force
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
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
    
    // helpers
    
    public func addBlur(_ style: UIBlurEffect.Style = .systemMaterial, intensity: CGFloat = 1.0) {
        let blurredView = VisualEffectView(style: style, intensity: intensity)
        blurredView.frame = bounds
        blurredView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurredView, at: 0)
    }
    
    public func addShadow(color: UIColor = .black, radius: CGFloat = 5, x: CGFloat = 0, y: CGFloat = 6, opacity: Float = 0.5) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = .init(width: x, height: y)
        layer.shadowOpacity = opacity
    }
    
    public func addBorder(_ edge: UIRectEdge, color: UIColor, width: CGFloat = 1) {
        let border = UIView()
        border.backgroundColor = color
        addSubview(border, tamic: false)
        
        switch edge {
        case .all:
            self.addBorder(color, width: width)
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
    }
    
    public func addBorder(_ color: UIColor, cornerRadius: CGFloat? = nil, width: CGFloat = 1) {
        if let cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    public func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    internal func alignInSuperview(_ alignment: ViewAlignment) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        switch alignment {
        case .fill:
            if hasWidthConstraint {
                return alignInSuperview(.fillVerticaly) }
            if hasHeightConstraint {
                return alignInSuperview(.fillHorizontaly)
            }
            edgeAnchors == superview.edgeAnchors
        case .fillTop:
            if hasWidthConstraint {
                return alignInSuperview(.top)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
        case .fillBottom:
            if hasWidthConstraint {
                return alignInSuperview(.bottom)
            }
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .fillLeading:
            if hasHeightConstraint {
                return alignInSuperview(.leading)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .fillTrailing:
            if hasHeightConstraint {
                return alignInSuperview(.trailing)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  <= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .fillHorizontaly:
            if hasWidthConstraint {
                return alignInSuperview(.center)
            }
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerYAnchor  == superview.centerYAnchor
        case .fillVerticaly:
            if hasHeightConstraint {
                return alignInSuperview(.center)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
        case .inSafeArea:
            topAnchor      == superview.safeAreaLayoutGuide.topAnchor
            leadingAnchor  == superview.safeAreaLayoutGuide.leadingAnchor
            trailingAnchor == superview.safeAreaLayoutGuide.trailingAnchor
            bottomAnchor   == superview.safeAreaLayoutGuide.bottomAnchor
        case .inSafeAreaIgnoringTop:
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.safeAreaLayoutGuide.leadingAnchor
            trailingAnchor == superview.safeAreaLayoutGuide.trailingAnchor
            bottomAnchor   == superview.safeAreaLayoutGuide.bottomAnchor
        case .inSafeAreaIgnoringBottom:
            topAnchor      == superview.safeAreaLayoutGuide.topAnchor
            leadingAnchor  == superview.safeAreaLayoutGuide.leadingAnchor
            trailingAnchor == superview.safeAreaLayoutGuide.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .center:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerAnchor   == superview.centerAnchor
        case .topLeading:
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
        case .top:
            topAnchor      == superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
        case .topTrailing:
            topAnchor      == superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
        case .leading:
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerYAnchor  == superview.centerYAnchor
        case .trailing:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerYAnchor  == superview.centerYAnchor
        case .bottomLeading:
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .bottom:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
        case .bottomTrailing:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        }
    }
}
