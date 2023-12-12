//
//  UIView + helpers.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit

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
    
    public func findFirst<V>(_ type: V.Type) -> V? where V: UIView {
        for view in subviews {
            if let v = view as? V {
                return v
            }
        }
        for view in subviews {
            if let v = view.findFirst(V.self) {
                return v
            }
        }
        return nil
    }
    
    public func findAll<V>(_ type: V.Type) -> [V] where V: UIView {
        var views: [V] = []
        
        for view in subviews {
            if let v = view as? V {
                views.append(v)
            }
            views.append(contentsOf: view.findAll(V.self))
        }
        return views
    }
}

internal class PaddingView: UIView {}

extension UIView {
    
    internal var hasWidth: Bool {
        if hasConstantWidth || widthPercentage != nil {
            true
        } else if !constraints(.aspectRatio).isEmpty {
            true
        } else if let pv = self as? PaddingView, pv.subviews.count == 1, let subview = subviews.first {
            subview.hasWidth || !subview.constraints(.aspectRatio).isEmpty
        } else {
            false
        }
    }
    internal var hasHeight: Bool {
        if hasConstantHeight || heightPercentage != nil {
            true
        } else if !constraints(.aspectRatio).isEmpty {
            true
        } else if let pv = self as? PaddingView, pv.subviews.count == 1, let subview = subviews.first {
            subview.hasHeight || !subview.constraints(.aspectRatio).isEmpty
        } else {
            false
        }
    }
    
    internal func alignInSuperview(_ alignment: ViewAlignment) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        var guide = UILayoutGuide()
        
        var canFillHorizontally: Bool {
            !(hasWidth && (superview.hasWidth || superview.isRootView))
        }
        var canFillVertically: Bool {
            !(hasHeight && (superview.hasHeight || superview.isRootView))
        }
        
        switch alignment {
        
        // MARK: Filling cases
        
        case .fill:
            if !canFillHorizontally { return alignInSuperview(.fillVerticaly) }
            if !canFillVertically   { return alignInSuperview(.fillHorizontaly) }
            edgeAnchors == superview.edgeAnchors
        case .fillVerticaly:
            if !canFillVertically { return alignInSuperview(.center) }
            if canFillHorizontally {
                leadingAnchor  >= superview.leadingAnchor
                trailingAnchor <= superview.trailingAnchor
            }
            topAnchor      == superview.topAnchor
            bottomAnchor   == superview.bottomAnchor
            centerXAnchor  == superview.centerXAnchor
        case .fillHorizontaly:
            if !canFillHorizontally { return alignInSuperview(.center) }
            if canFillVertically {
                topAnchor    >= superview.topAnchor
                bottomAnchor <= superview.bottomAnchor
            }
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            centerYAnchor  == superview.centerYAnchor
        case .fillTop:
            if !canFillHorizontally { return alignInSuperview(.top) }
            if canFillVertically {
                bottomAnchor <= superview.bottomAnchor
            }
            topAnchor      == superview.topAnchor
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
        case .fillBottom:
            if !canFillHorizontally { return alignInSuperview(.bottom) }
            if canFillVertically {
                topAnchor >= superview.topAnchor
            }
            leadingAnchor  == superview.leadingAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .fillLeading:
            if !canFillVertically { return alignInSuperview(.leading) }
            if canFillHorizontally {
                trailingAnchor <= superview.trailingAnchor
            }
            topAnchor     == superview.topAnchor
            leadingAnchor == superview.leadingAnchor
            bottomAnchor  == superview.bottomAnchor
        case .fillTrailing:
            if !canFillVertically { return alignInSuperview(.trailing) }
            if canFillHorizontally {
                leadingAnchor <= superview.leadingAnchor
            }
            topAnchor      == superview.topAnchor
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            
            
        // MARK: Corner cases
        
        case .topLeading:
            if canFillHorizontally {
                trailingAnchor <= superview.trailingAnchor
            }
            if canFillVertically {
                bottomAnchor <= superview.bottomAnchor
            }
            topAnchor     == superview.topAnchor
            leadingAnchor == superview.leadingAnchor
        case .topTrailing:
            if canFillHorizontally {
                leadingAnchor >= superview.leadingAnchor
            }
            if canFillVertically {
                bottomAnchor <= superview.bottomAnchor
            }
            topAnchor      == superview.topAnchor
            trailingAnchor == superview.trailingAnchor
        case .bottomLeading:
            if canFillHorizontally {
                trailingAnchor <= superview.trailingAnchor
            }
            if canFillVertically {
                topAnchor >= superview.topAnchor
            }
            leadingAnchor  == superview.leadingAnchor
            bottomAnchor   == superview.bottomAnchor
        case .bottomTrailing:
            if canFillHorizontally {
                leadingAnchor >= superview.leadingAnchor
            }
            if canFillVertically {
                topAnchor >= superview.topAnchor
            }
            trailingAnchor == superview.trailingAnchor
            bottomAnchor   == superview.bottomAnchor
            
            
        // MARK: Centering cases
        
        case .center:
            if canFillHorizontally {
                leadingAnchor  >= superview.leadingAnchor
                trailingAnchor <= superview.trailingAnchor
            }
            if canFillVertically {
                topAnchor    >= superview.topAnchor
                bottomAnchor <= superview.bottomAnchor
            }
            centerAnchor == superview.centerAnchor
        case .top:
            if canFillHorizontally {
                leadingAnchor  >= superview.leadingAnchor
                trailingAnchor <= superview.trailingAnchor
            }
            if canFillVertically {
                bottomAnchor <= superview.bottomAnchor
            }
            topAnchor     == superview.topAnchor
            centerXAnchor == superview.centerXAnchor
        case .leading:
            if canFillHorizontally  {
                trailingAnchor <= superview.trailingAnchor
            }
            if canFillVertically {
                topAnchor    >= superview.topAnchor
                bottomAnchor <= superview.bottomAnchor
            }
            leadingAnchor  == superview.leadingAnchor
            centerYAnchor  == superview.centerYAnchor
        case .trailing:
            if canFillHorizontally {
                leadingAnchor  >= superview.leadingAnchor
            }
            if canFillVertically {
                topAnchor      >= superview.topAnchor
                bottomAnchor   <= superview.bottomAnchor
            }
            trailingAnchor == superview.trailingAnchor
            centerYAnchor  == superview.centerYAnchor
        case .bottom:
            if canFillHorizontally {
                leadingAnchor  >= superview.leadingAnchor
                trailingAnchor <= superview.trailingAnchor
            }
            if canFillVertically {
                topAnchor >= superview.topAnchor
            }
            bottomAnchor  == superview.bottomAnchor
            centerXAnchor == superview.centerXAnchor
            
        // MARK: Safe Area cases
        
        case .inSafeArea:
            guide = superview.safeAreaLayoutGuide
            resolveFillingCase(using: guide)
        case .inSafeAreaIgnoringTop:
            superview.addLayoutGuide(guide)
            guide.topAnchor      == superview.topAnchor
            guide.leadingAnchor  == superview.safeAreaLayoutGuide.leadingAnchor
            guide.trailingAnchor == superview.safeAreaLayoutGuide.trailingAnchor
            guide.bottomAnchor   == superview.safeAreaLayoutGuide.bottomAnchor
            resolveFillingCase(using: guide)
        case .inSafeAreaIgnoringBottom:
            superview.addLayoutGuide(guide)
            guide.topAnchor      == superview.safeAreaLayoutGuide.topAnchor
            guide.leadingAnchor  == superview.safeAreaLayoutGuide.leadingAnchor
            guide.trailingAnchor == superview.safeAreaLayoutGuide.trailingAnchor
            guide.bottomAnchor   == superview.bottomAnchor
            resolveFillingCase(using: guide)
        case .aboveSafeArea:
            superview.addLayoutGuide(guide)
            guide.topAnchor      == superview.topAnchor
            guide.leadingAnchor  == superview.leadingAnchor
            guide.trailingAnchor == superview.trailingAnchor
            guide.bottomAnchor   == superview.safeAreaLayoutGuide.topAnchor
            resolveFillingCase(using: guide)
        case .belowSafeArea:
            superview.addLayoutGuide(guide)
            guide.topAnchor      == superview.safeAreaLayoutGuide.bottomAnchor
            guide.leadingAnchor  == superview.leadingAnchor
            guide.trailingAnchor == superview.trailingAnchor
            guide.bottomAnchor   == superview.bottomAnchor
            resolveFillingCase(using: guide)
        
        // MARK: AdditionalSafeAreaInsets cases
        
        case .topBar:
            layoutIfNeeded()
            controller?.additionalSafeAreaInsets.top = bounds.height
            if hasWidth {
                centerXAnchor == superview.centerXAnchor
            } else {
                leadingAnchor  == superview.leadingAnchor
                trailingAnchor == superview.trailingAnchor
            }
            bottomAnchor == superview.safeAreaLayoutGuide.topAnchor
        case .bottomBar:
            layoutIfNeeded()
            controller?.additionalSafeAreaInsets.bottom = bounds.height
            if hasWidth {
                centerXAnchor == superview.centerXAnchor
            } else {
                leadingAnchor  == superview.leadingAnchor
                trailingAnchor == superview.trailingAnchor
            }
            topAnchor == superview.safeAreaLayoutGuide.bottomAnchor
        }
        
        // MARK: Set Width, Height percentage if any
        
        if let widthPercentage {
            switch alignment {
            case .inSafeArea, .inSafeAreaIgnoringTop, .inSafeAreaIgnoringBottom, .aboveSafeArea, .belowSafeArea:
                widthAnchor == guide.widthAnchor * widthPercentage.value
            default:
                widthAnchor == superview.widthAnchor * widthPercentage.value
            }
        }
        if let heightPercentage {
            switch alignment {
            case .inSafeArea, .inSafeAreaIgnoringTop, .inSafeAreaIgnoringBottom, .aboveSafeArea, .belowSafeArea:
                heightAnchor == guide.heightAnchor * heightPercentage.value
            case .topBar, .bottomBar:
                break // Ignore!!! HeightPercentage cannot be set in this case (has self calculated height for additionalSafeAreaInsets)
            default:
                heightAnchor == superview.heightAnchor * heightPercentage.value
            }
        }
        
        // MARK: Resolve InSaveArea Case
        
        func resolveFillingCase(using guide: UILayoutGuide) {
            if hasWidth  { return fillVerticaly(using: guide) }
            if hasHeight { return fillHorizontaly(using: guide) }
            fill(using: guide)
            
            // helpers
            func fill(using guide: UILayoutGuide) {
                topAnchor      == guide.topAnchor
                leadingAnchor  == guide.leadingAnchor
                trailingAnchor == guide.trailingAnchor
                bottomAnchor   == guide.bottomAnchor
            }
            func fillVerticaly(using guide: UILayoutGuide) {
                if hasHeight { return center(using: guide) }
                if !hasWidth {
                    leadingAnchor  >= guide.leadingAnchor
                    trailingAnchor <= guide.trailingAnchor
                }
                topAnchor      == guide.topAnchor
                bottomAnchor   == guide.bottomAnchor
                centerXAnchor  == guide.centerXAnchor
            }
            func fillHorizontaly(using guide: UILayoutGuide) {
                if hasWidth { return center(using: guide) }
                if !hasHeight {
                    topAnchor    >= guide.topAnchor
                    bottomAnchor <= guide.bottomAnchor
                }
                leadingAnchor  == guide.leadingAnchor
                trailingAnchor == guide.trailingAnchor
                centerYAnchor  == guide.centerYAnchor
            }
            func center(using guide: UILayoutGuide) {
                if !hasWidth {
                    leadingAnchor  >= guide.leadingAnchor
                    trailingAnchor <= guide.trailingAnchor
                }
                if !hasHeight {
                    topAnchor    >= guide.topAnchor
                    bottomAnchor <= guide.bottomAnchor
                }
                centerXAnchor == guide.centerXAnchor
                centerYAnchor == guide.centerYAnchor
            }
        }
    }
}
