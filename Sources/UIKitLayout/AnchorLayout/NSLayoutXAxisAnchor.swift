//
//  NSLayoutXAxisAnchor.swift
//
//  Created by Yevhen Biiak on 27.08.2023.
//

import UIKit

extension NSLayoutXAxisAnchor {
    
    @discardableResult
    public static func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func >= (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        let constraint = lhs.constraint(greaterThanOrEqualTo: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func <= (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualTo: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func == (lhs: NSLayoutXAxisAnchor, rhs: ConstantTuple<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func >= (lhs: NSLayoutXAxisAnchor, rhs: ConstantTuple<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func <= (lhs: NSLayoutXAxisAnchor, rhs: ConstantTuple<NSLayoutXAxisAnchor>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func + (lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> ConstantTuple<NSLayoutXAxisAnchor> {
        return .init(anchor: lhs, constant: rhs)
    }
    
    @discardableResult
    public static func - (lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> ConstantTuple<NSLayoutXAxisAnchor> {
        return .init(anchor: lhs, constant: -rhs)
    }
}
