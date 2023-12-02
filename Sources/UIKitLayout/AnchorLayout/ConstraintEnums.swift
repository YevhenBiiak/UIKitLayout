//
//  ConstraintEnums.swift
//
//  Created by Yevhen Biiak on 24.09.2023.
//

import UIKit

public enum DimensionAttribute {
    case width, height
    internal var nsAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .width:  return .width
        case .height: return .height }
    }
}

public enum DimensionRelation {
    case itSelf
    case superview
    case subviews
}

public enum EdgeAttribute {
    case top, leading, trailing, bottom
    internal var nsAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top:      return .top
        case .leading:  return .leading
        case .trailing: return .trailing
        case .bottom:   return .bottom }
    }
}

public enum EdgeRelation {
    case superview
    case subviews
}
