//
//  ScrollView.swift
//
//  Created by Yevhen Biiak on 14.08.2023.
//

import UIKit
import AnchorLayout

extension UIScrollView {
    
    public convenience init(_ axis: NSLayoutConstraint.Axis, _ content: () -> UIView) {
        self.init(frame: .zero)
        let view = content()
        addSubview(view, tamic: false)
        view.edgeAnchors == edgeAnchors
        if axis == .horizontal {
            view.heightAnchor == frameLayoutGuide.heightAnchor
        } else {
            view.widthAnchor == frameLayoutGuide.widthAnchor
        }
    }
}
