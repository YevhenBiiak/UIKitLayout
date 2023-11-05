//
//  StackView.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit

@resultBuilder
public struct StackViewBuilder {
    public static func buildBlock() -> [UIView] { [] }
    public static func buildBlock(_ components: UIView...) -> [UIView] { components }
    public static func buildBlock(_ components: [UIView]...) -> [UIView] { components.flatMap { $0 } }
    public static func buildArray(_ components: [[UIView]]) -> [UIView] { components.flatMap { $0 } }
    public static func buildExpression(_ expression: Void) -> [UIView] { [] }
    public static func buildExpression(_ expression: UIView) -> [UIView] { [expression] }
    public static func buildOptional(_ component: [UIView]?) -> [UIView] { component ?? [] }
    public static func buildEither(first component: [UIView]) -> [UIView] { component }
    public static func buildEither(second component: [UIView]) -> [UIView] { component }
}

extension UIStackView: UIGestureRecognizerDelegate {
    
    public convenience init(_ axis: NSLayoutConstraint.Axis, @StackViewBuilder _ views: () -> [UIView]) {
        self.init()
        self.axis = axis
        let views = views()
        addArrangedSubviews(views)
        for view in views {
            if let widthPercentage = view.widthPercentage?.value {
                view.translatesAutoresizingMaskIntoConstraints = false
                view.widthAnchor == widthAnchor * widthPercentage
            }
            if let heightPercentage = view.heightPercentage?.value {
                view.translatesAutoresizingMaskIntoConstraints = false
                view.heightAnchor == heightAnchor * heightPercentage
            }
        }
    }
}
