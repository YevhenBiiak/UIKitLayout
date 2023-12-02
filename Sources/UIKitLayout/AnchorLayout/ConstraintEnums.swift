//
//  ConstraintEnums.swift
//
//  Created by Yevhen Biiak on 24.09.2023.
//

import UIKit

public enum DimensionAttribute {
    case width, height, aspectRatio
    internal var nsAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .width:       .width
        case .height:      .height
        case .aspectRatio: .notAnAttribute }
    }
}

public enum ConstraintAttribute {
    case top, leading, trailing, bottom, width, height
    internal var nsAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top:      .top
        case .leading:  .leading
        case .trailing: .trailing
        case .bottom:   .bottom
        case .width:    .width
        case .height:   .height }
    }
}

public enum ConstraintRelation {
    case superview
    case subviews
}
