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
    
    private struct AssociatedKeys {
        static var longPressAction   = "_longPressActions_"
        static var tapGestureAction  = "_tapGestureActions_"
        static var longPressHandler  = "_longPressHandlers_"
        static var tapGestureHandler = "_tapGestureHandlers_"
        static var widthPercentage   = "_widthPercentage_"
        static var heightPercentage  = "_heightPercentage_"
    }
    
    internal var longPressActions: [(() -> Void)] {
        get { getAssociatedObject(key: &AssociatedKeys.longPressAction) ?? [] }
        set { setAssociatedObject(key: &AssociatedKeys.longPressAction, value: newValue) }
    }
    internal var tapGestureActions: [(() -> Void)] {
        get { getAssociatedObject(key: &AssociatedKeys.tapGestureAction) ?? [] }
        set { setAssociatedObject(key: &AssociatedKeys.tapGestureAction, value: newValue) }
    }
    internal var longPressHandlers: [((UIView) -> Void)] {
        get { getAssociatedObject(key: &AssociatedKeys.longPressHandler) ?? [] }
        set { setAssociatedObject(key: &AssociatedKeys.longPressHandler, value: newValue) }
    }
    internal var tapGestureHandlers: [((UIView) -> Void)] {
        get { getAssociatedObject(key: &AssociatedKeys.tapGestureHandler) ?? [] }
        set { setAssociatedObject(key: &AssociatedKeys.tapGestureHandler, value: newValue) }
    }
    
    internal var widthPercentage: PostfixPercentage? {
        get { getAssociatedObject(key: &AssociatedKeys.widthPercentage) }
        set { setAssociatedObject(key: &AssociatedKeys.widthPercentage, value: newValue) }
    }
    internal var heightPercentage: PostfixPercentage? {
        get { getAssociatedObject(key: &AssociatedKeys.heightPercentage) }
        set { setAssociatedObject(key: &AssociatedKeys.heightPercentage, value: newValue) }
    }
}
