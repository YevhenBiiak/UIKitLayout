//
//  UIView + helpers.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit
import AnchorLayout

extension UIView {
    
    public func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    internal func alignInSuperview(_ alignment: ViewAlignment) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        switch alignment {
        case .fill:
            if hasWidthConstraint {
                return alignInSuperview(.fillVerticaly) }
            if hasHeightConstraint {
                return alignInSuperview(.fillHorizontaly)
            }
            edgeAnchors == superview.edgeAnchors
        case .fillTop:
            if hasWidthConstraint {
                return alignInSuperview(.top)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
        case .fillBottom:
            if hasWidthConstraint {
                return alignInSuperview(.bottom)
            }
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .fillLeading:
            if hasHeightConstraint {
                return alignInSuperview(.leading)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .fillTrailing:
            if hasHeightConstraint {
                return alignInSuperview(.trailing)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  <= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .fillHorizontaly:
            if hasWidthConstraint {
                return alignInSuperview(.center)
            }
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerYAnchor  == superview.centerYAnchor
        case .fillVerticaly:
            if hasHeightConstraint {
                return alignInSuperview(.center)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
        case .inSafeArea:
            topAnchor      == superview.safeAreaLayoutGuide.topAnchor
            leadingAnchor  == superview.safeAreaLayoutGuide.leadingAnchor
            trailingAnchor == superview.safeAreaLayoutGuide.trailingAnchor
            bottomAnchor   == superview.safeAreaLayoutGuide.bottomAnchor
        case .inSafeAreaIgnoringTop:
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.safeAreaLayoutGuide.leadingAnchor
            trailingAnchor == superview.safeAreaLayoutGuide.trailingAnchor
            bottomAnchor   == superview.safeAreaLayoutGuide.bottomAnchor
        case .inSafeAreaIgnoringBottom:
            topAnchor      == superview.safeAreaLayoutGuide.topAnchor
            leadingAnchor  == superview.safeAreaLayoutGuide.leadingAnchor
            trailingAnchor == superview.safeAreaLayoutGuide.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .center:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerAnchor   == superview.centerAnchor
        case .topLeading:
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
        case .top:
            topAnchor      == superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
        case .topTrailing:
            topAnchor      == superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
        case .leading:
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerYAnchor  == superview.centerYAnchor
        case .trailing:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerYAnchor  == superview.centerYAnchor
        case .bottomLeading:
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .bottom:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
        case .bottomTrailing:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        }
    }
}
