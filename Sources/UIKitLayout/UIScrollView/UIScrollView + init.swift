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
        
        view.edgeAnchors == self.contentLayoutGuide.edgeAnchors
        
        if let widthMultiplier = view.widthPercentage?.value {
            view.widthAnchor == self.frameLayoutGuide.widthAnchor * widthMultiplier }
        if let heightMultiplier = view.heightPercentage?.value {
            view.heightAnchor == self.frameLayoutGuide.heightAnchor * heightMultiplier
        }
        
        if axis == .horizontal, !view.hasHeight {
            view.heightAnchor == self.frameLayoutGuide.heightAnchor }
        if axis == .vertical, !view.hasWidth {
            view.widthAnchor == self.frameLayoutGuide.widthAnchor
        }
    }
}
