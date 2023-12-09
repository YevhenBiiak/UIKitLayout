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
            if let widthMultiplier = view.widthPercentage?.value {
                view.widthAnchor == self.widthAnchor * widthMultiplier
            }
            if let heightMultiplier = view.heightPercentage?.value {
                view.heightAnchor == self.heightAnchor * heightMultiplier
            } else if !view.hasHeight {
                view.heightAnchor == self.frameLayoutGuide.heightAnchor
            }
        } else {
            if let heightMultiplier = view.heightPercentage?.value {
                view.heightAnchor == self.heightAnchor * heightMultiplier
            }
            if let widthMultiplier = view.widthPercentage?.value {
                view.widthAnchor == self.widthAnchor * widthMultiplier
            } else if !view.hasWidth {
                view.widthAnchor == self.frameLayoutGuide.widthAnchor
            }
        }
    }
}
