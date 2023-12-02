//
//  ConstraintHelpers.swift
//
//  Created by Yevhen Biiak on 10.06.2023.
//

import UIKit

extension UIView {
    
    public func addSubview(_ view: UIView, tamic: Bool) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = tamic
    }
    
    public func insertSubview(_ view: UIView, at index: Int, tamic: Bool) {
        insertSubview(view, at: index)
        view.translatesAutoresizingMaskIntoConstraints = tamic
    }
}

// MARK: Getting Constraints methods

extension UIView {
    
    /// returns a constraints with a width or height attribute and a constant value
    public func constraints(_ attribute: DimensionAttribute) -> [NSLayoutConstraint] {
        constraints.filter {
            (($0.firstItem  as? NSObject) == self && $0.firstAttribute == attribute.nsAttribute) &&
            ($0.secondItem == nil && $0.secondAttribute == .notAnAttribute)
        }
    }
    
    public func constraints(_ attribute: DimensionAttribute, to relation: DimensionRelation) -> [NSLayoutConstraint] {
        switch relation {
        case .itSelf:
            let constraints = self.constraints
            return constraints.filter {
                (
                    (($0.firstItem  as? NSObject) == self && $0.firstAttribute == attribute.nsAttribute) &&
                    (($0.secondItem as? NSObject) == self)
                ) || (
                    (($0.secondItem as? NSObject) == self && $0.secondAttribute == attribute.nsAttribute) &&
                    (($0.firstItem  as? NSObject) == self)
                )
            }
        case .superview:
            let constraints = self.constraints + (superview?.constraints ?? [])
            return constraints.filter {
                (
                    (($0.firstItem  as? NSObject) == self && $0.firstAttribute == attribute.nsAttribute) &&
                    (($0.secondItem as? NSObject) == superview)
                ) || (
                    (($0.secondItem as? NSObject) == self && $0.secondAttribute == attribute.nsAttribute) &&
                    (($0.firstItem  as? NSObject) == superview)
                )
            }
        case .subviews:
            let constraints = self.constraints + subviews.flatMap(\.constraints)
            return constraints.filter {
                (
                    (($0.firstItem  as? NSObject) == self && $0.firstAttribute == attribute.nsAttribute) &&
                    subviews.contains(item: $0.secondItem)
                ) || (
                    (($0.secondItem as? NSObject) == self && $0.secondAttribute == attribute.nsAttribute) &&
                    subviews.contains(item: $0.firstItem)
                )
            }
        }
    }
    
    public func constraints(_ attribute: EdgeAttribute, to relation: EdgeRelation) -> [NSLayoutConstraint] {
        
        switch relation {
        case .superview:
            let constraints = self.constraints + (superview?.constraints ?? [])
            return constraints.filter {
                (
                    (($0.firstItem  as? NSObject) == self && $0.firstAttribute  == attribute.nsAttribute) &&
                    (($0.secondItem as? NSObject) == superview)
                ) || (
                    (($0.secondItem as? NSObject) == self && $0.secondAttribute == attribute.nsAttribute) &&
                    (($0.firstItem  as? NSObject) == superview)
                )
            }
        case .subviews:
            let constraints = self.constraints + subviews.flatMap(\.constraints)
            return constraints.filter {
                (
                    (($0.firstItem  as? NSObject) == self && $0.firstAttribute  == attribute.nsAttribute) &&
                    subviews.contains(item: $0.secondItem)
                ) || (
                    (($0.secondItem as? NSObject) == self && $0.secondAttribute == attribute.nsAttribute) &&
                    subviews.contains(item: $0.firstItem)
                )
            }
        }
    }
}


// MARK: Removing Constraint methods

extension UIView {
    
    internal var hasConstantWidth: Bool {
        !constraints(.width).isEmpty
    }
    
    internal var hasConstantHeight: Bool {
        !constraints(.height).isEmpty
    }
    
    // MARK: DimensionAttribute
    
    internal func removeConstraints(_ attribute: DimensionAttribute) {
        constraints(attribute).forEach { $0.remove() }
    }
    
    internal func removeConstraints(_ attributes: [DimensionAttribute]) {
        attributes.forEach { removeConstraints($0) }
    }
    
    // MARK: DimensionAttribute and relation
    
    internal func removeConstraints(_ attribute: DimensionAttribute, to relation: DimensionRelation) {
        constraints(attribute, to: relation).forEach { $0.remove() }
    }
    
    internal func removeConstraints(_ attributes: [DimensionAttribute], to relation: DimensionRelation) {
        attributes.forEach { removeConstraints($0, to: relation) }
    }
    
    // MARK: EdgeAttribute and relation
    
    internal func removeConstraints(_ attribute: EdgeAttribute, to relation: EdgeRelation) {
        constraints(attribute, to: relation).forEach { $0.remove() }
    }
    
    internal func removeConstraints(_ attributes: [EdgeAttribute], to relation: EdgeRelation) {
        attributes.forEach { removeConstraints($0, to: relation) }
    }
}

extension NSLayoutConstraint {
    public func remove() {
        (firstItem  as? UIView)?.removeConstraint(self)
        (secondItem as? UIView)?.removeConstraint(self)
    }
}

private extension Array<UIView> {
    func contains(item: Any?) -> Bool {
        if let obj = item as? UIView {
            contains(obj)
        } else {
            false
        }
    }
}
