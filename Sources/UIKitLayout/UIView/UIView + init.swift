//
//  UIView + init.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit

public protocol UIViewContainerable {}
extension UIView: UIViewContainerable {}

extension UIViewContainerable {
    public init(_ alignment: ViewAlignment, _ content: () -> UIView) where Self == UIView {
        self.init()
        let view = content()
        self.addSubview(view)
        view.alignInSuperview(alignment)
    }
}

extension UIView {
    
    private struct UKLAssociatedKeys {
        static var _ukl_longPressHandler  = "_ukl_longPressHandler"
        static var _ukl_tapGestureHandler = "_ukl_tapGestureHandler"
        static var _ukl_widthPercentage   = "_ukl_widthPercentage"
        static var _ukl_heightPercentage  = "_ukl_heightPercentage"
        static var _ukl_shadowLayer      = "_ukl_shadowLayer"
        static var _ukl_constraintInsets = "_ukl_constraintInsets"
    }
    
    internal var longPressHandler: ((UILongPressGestureRecognizer) -> Void)? {
        get { getAssociatedObject(key: &UKLAssociatedKeys._ukl_longPressHandler) }
        set { setAssociatedObject(key: &UKLAssociatedKeys._ukl_longPressHandler, value: newValue) }
    }
    internal var tapGestureHandler: ((UITapGestureRecognizer) -> Void)? {
        get { getAssociatedObject(key: &UKLAssociatedKeys._ukl_tapGestureHandler) }
        set { setAssociatedObject(key: &UKLAssociatedKeys._ukl_tapGestureHandler, value: newValue) }
    }
    
    internal var widthPercentage: UKLPostfixPercentage? {
        get { getAssociatedObject(key: &UKLAssociatedKeys._ukl_widthPercentage) }
        set { setAssociatedObject(key: &UKLAssociatedKeys._ukl_widthPercentage, value: newValue) }
    }
    internal var heightPercentage: UKLPostfixPercentage? {
        get { getAssociatedObject(key: &UKLAssociatedKeys._ukl_heightPercentage) }
        set { setAssociatedObject(key: &UKLAssociatedKeys._ukl_heightPercentage, value: newValue) }
    }

    internal var _shadowLayer: CALayer? {
        get { getAssociatedObject(key: &UKLAssociatedKeys._ukl_shadowLayer) }
        set { setAssociatedObject(key: &UKLAssociatedKeys._ukl_shadowLayer, value: newValue) }
    }
    
    internal var _constraintInsets: UIEdgeInsets {
        get { getAssociatedObject(key: &UKLAssociatedKeys._ukl_constraintInsets) ?? .zero }
        set { setAssociatedObject(key: &UKLAssociatedKeys._ukl_constraintInsets, value: newValue) }
    }
}
