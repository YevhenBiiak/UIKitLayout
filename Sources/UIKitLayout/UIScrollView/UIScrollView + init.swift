//
//  ScrollView.swift
//
//  Created by Yevhen Biiak on 14.08.2023.
//

import UIKit

public protocol UIScrollViewInitializable {}
extension UIScrollView: UIScrollViewInitializable {}

extension UIScrollViewInitializable {
    
    public init(_ axis: NSLayoutConstraint.Axis, _ content: () -> UIView) where Self == UIScrollView {
        self.init(frame: .zero)
        let view = content()
        self.addSubview(view, tamic: false)
        view.edgeAnchors == self.edgeAnchors
        if axis == .horizontal {
            view.heightAnchor == self.frameLayoutGuide.heightAnchor
        } else {
            view.widthAnchor == self.frameLayoutGuide.widthAnchor
        }
    }
}
