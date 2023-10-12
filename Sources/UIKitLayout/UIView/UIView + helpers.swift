//
//  UIView + helpers.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit
import AnchorLayout

extension UIView {
    
    public var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public var isRootView: Bool {
        rootView === self
    }
    
    public var rootView: UIView? {
        controller?.view
    }
    
    public var controller: UIViewController? {
        for responder in sequence(first: self, next: { $0.next }) {
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    public func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
    
    internal func alignInSuperview(_ alignment: ViewAlignment) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        switch alignment {
        
        // MARK: Filling cases
        
        case .fill:
            if hasWidthConstraint || widthPercentage != nil {
                return alignInSuperview(.fillVerticaly) }
            if hasHeightConstraint || heightPercentage != nil {
                return alignInSuperview(.fillHorizontaly)
            }
            edgeAnchors == superview.edgeAnchors
        case .fillVerticaly:
            if hasHeightConstraint || heightPercentage != nil {
                return alignInSuperview(.center)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
        case .fillHorizontaly:
            if hasWidthConstraint || widthPercentage != nil {
                return alignInSuperview(.center)
            }
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerYAnchor  == superview.centerYAnchor
        case .fillTop:
            if hasWidthConstraint || widthPercentage != nil {
                return alignInSuperview(.top)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
        case .fillBottom:
            if hasWidthConstraint || widthPercentage != nil {
                return alignInSuperview(.bottom)
            }
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .fillLeading:
            if hasHeightConstraint || heightPercentage != nil {
                return alignInSuperview(.leading)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .fillTrailing:
            if hasHeightConstraint || heightPercentage != nil {
                return alignInSuperview(.trailing)
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  <= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            
        // MARK: Corner cases
        
        case .topLeading:
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
        case .topTrailing:
            topAnchor      == superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
        case .bottomLeading:
            topAnchor      >= superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .bottomTrailing:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            
        // MARK: Centering cases
        
        case .center:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerAnchor   == superview.centerAnchor
        case .top:
            topAnchor      == superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   <= superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
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
        case .bottom:
            topAnchor      >= superview.topAnchor
            leadingAnchor  >= superview.leadingAnchor
            trailingAnchor <= superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
            
        // MARK: Safe Area cases
        
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
        case .aboveSafeArea:
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.safeAreaLayoutGuide.topAnchor
        case .belowSafeArea:
            topAnchor      == superview.safeAreaLayoutGuide.bottomAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        
        // MARK: AdditionalSafeAreaInsets cases
        
        case .topBar:
            layoutIfNeeded()
            controller?.additionalSafeAreaInsets.top = bounds.height
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.safeAreaLayoutGuide.topAnchor
        case .bottomBar:
            layoutIfNeeded()
            controller?.additionalSafeAreaInsets.bottom = bounds.height
            topAnchor      == superview.safeAreaLayoutGuide.bottomAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
        }
        
        // MARK: Set Width, Height precentage if any
        
        if let widthPercentage {
            widthAnchor == superview.widthAnchor * widthPercentage.value
        }
        if let heightPercentage {
            heightAnchor == superview.heightAnchor * heightPercentage.value
        }
    }
}
