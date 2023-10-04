//
//  UIView + init.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit

extension UIView {
    
    private struct AssociatedKeys {
        static var longPressAction = "longPressActions"
        static var tapGestureAction = "tapGestureActions"
        static var longPressHandler = "longPressHandlers"
        static var tapGestureHandler = "tapGestureHandlers"
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
}
