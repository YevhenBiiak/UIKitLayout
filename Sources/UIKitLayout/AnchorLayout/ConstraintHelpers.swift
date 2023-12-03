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
    public func constraints(_ attribute: ConstraintAttribute) -> [NSLayoutConstraint] {
        switch attribute {
        case .top, .bottom, .leading, .trailing:
            (constraints + (superview?.constraints ?? [])).filter {
                (
                    (($0.firstItem  as? NSObject) == self && $0.firstAttribute == attribute.nsAttribute) &&
                    (($0.secondItem as? NSObject) == superview)
                ) || (
                    (($0.secondItem as? NSObject) == self && $0.secondAttribute == attribute.nsAttribute) &&
                    (($0.firstItem  as? NSObject) == superview)
                )
            }
        case .width, .height:
            constraints.filter {
                (($0.firstItem  as? NSObject) == self && $0.firstAttribute == attribute.nsAttribute) &&
                ($0.secondItem == nil && $0.secondAttribute == .notAnAttribute)
            }
        case .aspectRatio:
            constraints.filter {
                (
                    (($0.firstItem  as? NSObject) == self && $0.firstAttribute  == .width) &&
                    (($0.secondItem as? NSObject) == self && $0.secondAttribute == .height)
                ) || (
                    (($0.firstItem  as? NSObject) == self && $0.firstAttribute  == .height) &&
                    (($0.secondItem as? NSObject) == self && $0.secondAttribute == .width)
                )
            }
        }
    }
    
    public func constraints(_ attribute: ConstraintRelatedAttribute, to relation: ConstraintRelation) -> [NSLayoutConstraint] {
        switch relation {
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
}


// MARK: Removing Constraint methods

extension UIView {
    
    internal var hasConstantWidth: Bool {
        !constraints(.width).isEmpty
    }
    
    internal var hasConstantHeight: Bool {
        !constraints(.height).isEmpty
    }
    
    internal var hasAspectRatio: Bool {
        !constraints(.aspectRatio).isEmpty
    }
    
    // MARK: DimensionAttribute
    
    internal func removeConstraints(_ attribute: ConstraintAttribute) {
        constraints(attribute).forEach { $0.remove() }
    }
    
    internal func removeConstraints(_ attributes: [ConstraintAttribute]) {
        attributes.forEach { removeConstraints($0) }
    }
    
    // MARK: ConstraintAttribute and relation
    
    internal func removeConstraints(_ attribute: ConstraintRelatedAttribute, to relation: ConstraintRelation) {
        constraints(attribute, to: relation).forEach { $0.remove() }
    }
    
    internal func removeConstraints(_ attributes: [ConstraintRelatedAttribute], to relation: ConstraintRelation) {
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
