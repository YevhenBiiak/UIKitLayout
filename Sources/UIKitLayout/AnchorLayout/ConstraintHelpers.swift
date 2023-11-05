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
    
    public var hasWidthConstraint: Bool {
        !constraints(.width).isEmpty
    }
    
    public var hasHeightConstraint: Bool {
        !constraints(.height).isEmpty
    }
    
    public func constraints(_ attribute: DimensionAttribute) -> [NSLayoutConstraint] {
        constraints.filter {
            ($0.firstItem  as? NSObject) == self && $0.firstAttribute == attribute.nsAttribute
        }
    }
    
    public func constraints(_ attribute: DimensionAttribute, relativeTo relation: ConstraintRelation) -> [NSLayoutConstraint] {
        switch relation {
        case .superview:
            let constraints = Set(self.constraints + (superview?.constraints ?? []))
            return constraints.filter {
                (
                    (($0.firstItem  as? NSObject) == self      && $0.firstAttribute  == attribute.nsAttribute) &&
                    (($0.secondItem as? NSObject) == superview && $0.secondAttribute == attribute.nsAttribute)
                ) || (
                    (($0.firstItem  as? NSObject) == superview && $0.firstAttribute  == attribute.nsAttribute) &&
                    (($0.secondItem as? NSObject) == self      && $0.secondAttribute == attribute.nsAttribute)
                )
            }
        case .subviews:
            let constraints = self.constraints.filter {
                (($0.firstItem  as? NSObject) == self && $0.firstAttribute  == attribute.nsAttribute) ||
                (($0.secondItem as? NSObject) == self && $0.secondAttribute == attribute.nsAttribute)
            }
            return constraints.filter {
                for subview in subviews {
                    if (($0.firstItem  as? NSObject) == subview && $0.firstAttribute  == attribute.nsAttribute) ||
                       (($0.secondItem as? NSObject) == subview && $0.secondAttribute == attribute.nsAttribute) {
                        return true
                    }
                }
                return false
            }
        }
    }
    
    public func constraints(_ attribute: EdgeAttribute, to relation: ConstraintRelation) -> [NSLayoutConstraint] {
        
        let constraints = constraints.filter {
            (($0.firstItem  as? NSObject) == self && $0.firstAttribute  == attribute.nsAttribute) ||
            (($0.secondItem as? NSObject) == self && $0.secondAttribute == attribute.nsAttribute)
        }
        
        switch relation {
        case .superview:
            return constraints.filter {
                ($0.firstItem  as? NSObject) == self.superview ||
                ($0.secondItem as? NSObject) == self.superview
            }
        case .subviews:
            return constraints.filter {
                for subview in subviews {
                    if ($0.firstItem as? NSObject) == subview ||
                        ($0.secondItem as? NSObject) == subview {
                        return true
                    }
                }
                return false
            }
        }
    }
    
    public func removeConstraints(_ attributes: [EdgeAttribute], to relation: ConstraintRelation) {
        attributes.forEach { attribute in
            constraints(attribute, to: relation).forEach { constraint in
                removeConstraint(constraint)
            }
        }
    }
    
    public func removeConstraints(_ attributes: [DimensionAttribute]) {
        attributes.forEach { attribute in
            constraints(attribute).forEach { constraint in
                removeConstraint(constraint)
            }
        }
    }
    
    public func removeConstraints(_ attribute: EdgeAttribute, to relation: ConstraintRelation) {
        removeConstraints([attribute], to: relation)
    }
    
    public func removeConstraints(_ attribute: DimensionAttribute) {
        removeConstraints([attribute])
    }
    
    public func removeConstraints(_ attribute: DimensionAttribute, relativeTo relation: ConstraintRelation) {
        constraints(attribute, relativeTo: relation).forEach { constraint in
            removeConstraint(constraint)
        }
    }
}
