//
//  UIButton + helpers.swift
//
//  Created by Yevhen Biiak on 19.08.2023.
//

import UIKit

extension UIButton {
    
    public func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ action: @escaping () -> Void) {
        addAction(UIAction { _ in action() }, for: controlEvents)
    }
}
