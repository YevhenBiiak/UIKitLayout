//
//  UIView + init.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit

extension UIView {
    
    private struct AssociatedKeys {
        static var longPressAction = "longPressAction"
        static var tapGestureAction = "tapGestureAction"
        static var longPressHandler = "longPressHandler"
        static var tapGestureHandler = "tapGestureHandler"
    }
    
    internal var longPressAction: (() -> Void)? {
        get { getAssociatedObject(key: &AssociatedKeys.longPressAction) }
        set { setAssociatedObject(key: &AssociatedKeys.longPressAction, value: newValue) }
    }
    internal var tapGestureAction: (() -> Void)? {
        get { getAssociatedObject(key: &AssociatedKeys.tapGestureAction) }
        set { setAssociatedObject(key: &AssociatedKeys.tapGestureAction, value: newValue) }
    }
    internal var longPressHandler: ((UIView) -> Void)? {
        get { getAssociatedObject(key: &AssociatedKeys.longPressHandler) }
        set { setAssociatedObject(key: &AssociatedKeys.longPressHandler, value: newValue) }
    }
    internal var tapGestureHandler: ((UIView) -> Void)? {
        get { getAssociatedObject(key: &AssociatedKeys.tapGestureHandler) }
        set { setAssociatedObject(key: &AssociatedKeys.tapGestureHandler, value: newValue) }
    }
}
