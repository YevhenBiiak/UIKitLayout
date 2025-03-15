//
//  UIControl + helpers.swift
//
//  Created by Yevhen Biiak on 19.08.2023.
//

import UIKit

extension UIControl {
    @available(iOS 14.0, *)
    public func addAction(for controlEvents: UIControl.Event, _ action: @escaping () -> Void) {
        addAction(UIAction { _ in action() }, for: controlEvents)
    }
    
    @available(iOS 14.0, *)
    public func addAction(for controlEvents: UIControl.Event, _ action: @escaping (_ action: UIAction) -> Void) {
        addAction(UIAction { action($0) }, for: controlEvents)
    }
}
