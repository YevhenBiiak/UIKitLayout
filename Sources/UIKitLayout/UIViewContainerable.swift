//
//  UIViewContainerable.swift
//  UIKitLayoutPlayground
//
//  Created by Yevhen Biiak on 10.10.2023.
//

import UIKit

protocol UIViewContainerable {}
extension UIView: UIViewContainerable {}

extension UIViewContainerable {
    init(_ alignment: ViewAlignment, _ content: () -> UIView) where Self == UIView {
        self.init()
        let view = content()
        self.addSubview(view)
        view.alignInSuperview(alignment)
    }
}
