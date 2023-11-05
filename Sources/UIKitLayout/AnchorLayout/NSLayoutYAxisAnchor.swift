//
//  NSLayoutYAxisAnchor.swift
//
//  Created by Yevhen Biiak on 27.08.2023.
//

import UIKit

extension NSLayoutYAxisAnchor {
    
    @discardableResult
    public static func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func >= (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        let constraint = lhs.constraint(greaterThanOrEqualTo: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func <= (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualTo: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func == (lhs: NSLayoutYAxisAnchor, rhs: ConstantTuple<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func <= (lhs: NSLayoutYAxisAnchor, rhs: ConstantTuple<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func >= (lhs: NSLayoutYAxisAnchor, rhs: ConstantTuple<NSLayoutYAxisAnchor>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func + (lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> ConstantTuple<NSLayoutYAxisAnchor> {
        return .init(anchor: lhs, constant: rhs)
    }
    
    @discardableResult
    public static func - (lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> ConstantTuple<NSLayoutYAxisAnchor> {
        return .init(anchor: lhs, constant: -rhs)
    }
}
