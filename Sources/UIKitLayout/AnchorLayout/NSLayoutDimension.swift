//
//  NSLayoutDimension.swift
//
//  Created by Yevhen Biiak on 27.08.2023.
//

import UIKit

extension NSLayoutDimension {
    
    @discardableResult
    public static func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func == (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalToConstant: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        let constraint = lhs.constraint(greaterThanOrEqualToConstant: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualToConstant: rhs)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func == (lhs: NSLayoutDimension, rhs: MultiplierTuple<NSLayoutDimension>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs.anchor, multiplier: rhs.multiplier)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func >= (lhs: NSLayoutDimension, rhs: MultiplierTuple<NSLayoutDimension>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func <= (lhs: NSLayoutDimension, rhs: MultiplierTuple<NSLayoutDimension>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor, multiplier: rhs.multiplier)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func == (lhs: NSLayoutDimension, rhs: ConstantTuple<NSLayoutDimension>) -> NSLayoutConstraint {
        let constraint = lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    public static func + (lhs: NSLayoutDimension, rhs: CGFloat) -> ConstantTuple<NSLayoutDimension> {
        return .init(anchor: lhs, constant: rhs)
    }
    
    @discardableResult
    public static func - (lhs: NSLayoutDimension, rhs: CGFloat) -> ConstantTuple<NSLayoutDimension> {
        return .init(anchor: lhs, constant: -rhs)
    }
    
    @discardableResult
    public static func * (lhs: NSLayoutDimension, rhs: CGFloat) -> MultiplierTuple<NSLayoutDimension> {
        return .init(anchor: lhs, multiplier: rhs)
    }
    
    @discardableResult
    public static func / (lhs: NSLayoutDimension, rhs: CGFloat) -> MultiplierTuple<NSLayoutDimension> {
        return .init(anchor: lhs, multiplier: 1 / rhs)
    }
    
    @discardableResult
    public static func / (lhs: NSLayoutDimension, rhs: Int) -> MultiplierTuple<NSLayoutDimension> {
        return .init(anchor: lhs, multiplier: 1 / CGFloat(rhs))
    }
}
