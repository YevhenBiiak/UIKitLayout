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

private extension UIStackView {
    
    internal var canStretchHorizontally: Bool {
        arrangedSubviews.contains { !$0.hasWidth }
    }
    internal var canStretchVertically: Bool {
        arrangedSubviews.contains { !$0.hasHeight }
    }
}

extension UIView {
    
    private var firstSubviewThatFills: UIView? {
        subviews.first {
            !$0.constraints(.top,      to: .superview).isEmpty &&
            !$0.constraints(.leading,  to: .superview).isEmpty &&
            !$0.constraints(.trailing, to: .superview).isEmpty &&
            !$0.constraints(.bottom,   to: .superview).isEmpty
        }
    }
    
    private var isReusableCell: Bool {
        (self is UICollectionViewCell) || (superview is UICollectionViewCell) ||
        (self is UITableViewCell)      || (superview is UITableViewCell)
    }
    
    private var hasWidthConstraint: Bool {
        if !constraints(.width).isEmpty {
            true
        } else if let subview = firstSubviewThatFills {
            subview.hasWidthConstraint
        } else {
            false
        }
    }
    
    private var hasHeightConstraint: Bool {
        if !constraints(.height).isEmpty {
            true
        } else if let subview = firstSubviewThatFills {
            subview.hasHeightConstraint
        } else {
            false
        }
    }
    
    private var hasWidthPercentage: Bool {
        widthPercentage != nil
    }
    
    private var hasHeightPercentage: Bool {
        heightPercentage != nil
    }
    
    private var hasAspectRatio: Bool {
        if isRootView || isReusableCell {
            true
        } else if !constraints(.aspectRatio).isEmpty {
            true
        } else if let subview = firstSubviewThatFills {
            subview.hasAspectRatio
        } else {
            false
        }
    }
    
    internal var hasWidth: Bool {
        if isRootView || isReusableCell {
            true
        } else if hasAspectRatio && (hasWidthConstraint || hasHeightConstraint || hasWidthPercentage || hasHeightPercentage) {
            true
        } else if hasWidthConstraint || hasWidthPercentage {
            true
        } else if let stack = self as? UIStackView {
            !stack.canStretchHorizontally
        } else {
            false
        }
    }
    
    internal var hasHeight: Bool {
        if isRootView || isReusableCell {
            true
        } else if hasAspectRatio && (hasWidthConstraint || hasHeightConstraint || hasWidthPercentage || hasHeightPercentage) {
            true
        } else if hasHeightConstraint || hasHeightPercentage {
            true
        } else if let stack = self as? UIStackView {
            !stack.canStretchVertically
        } else {
            false
        }
    }
    
    internal func alignInSuperview(_ alignment: ViewAlignment) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        var guide = UILayoutGuide()
        
        var canFillHorizontally: Bool {
            !hasWidth || !superview.hasWidth
        }
        var canFillVertically: Bool {
            !hasHeight || !superview.hasHeight
        }
        var needPinHorizontally: Bool {
            !hasWidth
        }
        var needPinVertically: Bool {
            !hasHeight
        }
        
        switch alignment {
        
        // MARK: Filling cases
        
        case .fill:
            if !canFillHorizontally { return alignInSuperview(.fillVerticaly) }
            if !canFillVertically   { return alignInSuperview(.fillHorizontaly) }
            pin(.top, .leading, .trailing, .bottom)
        case .fillVerticaly:
            if !canFillVertically { return alignInSuperview(.center) }
            if needPinHorizontally {
                pin(.flexibleLeading, .flexibleTailing)
            }
            pin(.top, .bottom, .centerX)
        case .fillHorizontaly:
            if !canFillHorizontally { return alignInSuperview(.center) }
            if needPinVertically {
                pin(.flexibleTop, .flexibleBottom)
            }
            pin(.leading, .trailing, .centerY)
        case .fillTop:
            if !canFillHorizontally { return alignInSuperview(.top) }
            if needPinVertically {
                pin(.flexibleBottom)
            }
            pin(.top, .leading, .trailing)
        case .fillBottom:
            if !canFillHorizontally { return alignInSuperview(.bottom) }
            if needPinVertically {
                pin(.flexibleTop)
            }
            pin(.leading, .trailing, .bottom)
        case .fillLeading:
            if !canFillVertically { return alignInSuperview(.leading) }
            if needPinHorizontally {
                pin(.flexibleTailing)
            }
            pin(.top, .leading, .bottom)
        case .fillTrailing:
            if !canFillVertically { return alignInSuperview(.trailing) }
            if needPinHorizontally {
                pin(.flexibleLeading)
            }
            pin(.top, .trailing, .bottom)
            
            
        // MARK: Corner cases
        
        case .topLeading:
            if needPinHorizontally {
                pin(.flexibleTailing)
            }
            if needPinVertically {
                pin(.flexibleBottom)
            }
            pin(.top, .leading)
        case .topTrailing:
            if needPinHorizontally {
                pin(.flexibleLeading)
            }
            if needPinVertically {
                pin(.flexibleBottom)
            }
            pin(.top, .trailing)
        case .bottomLeading:
            if needPinHorizontally {
                pin(.flexibleTailing)
            }
            if needPinVertically {
                pin(.flexibleTop)
            }
            pin(.leading, .bottom)
        case .bottomTrailing:
            if needPinHorizontally {
                pin(.flexibleLeading)
            }
            if needPinVertically {
                pin(.flexibleTop)
            }
            pin(.trailing, .bottom)
            
            
        // MARK: Centering cases
        
        case .center:
            if needPinHorizontally {
                pin(.flexibleLeading, .flexibleTailing)
            }
            if needPinVertically {
                pin(.flexibleTop, .flexibleBottom)
            }
            pin(.centerX, .centerY)
        case .top:
            if needPinHorizontally {
                pin(.flexibleLeading, .flexibleTailing)
            }
            if needPinVertically {
                pin(.flexibleBottom)
            }
            pin(.top, .centerX)
        case .leading:
            if needPinHorizontally  {
                pin(.flexibleTailing)
            }
            if needPinVertically {
                pin(.flexibleTop, .flexibleBottom)
            }
            pin(.leading, .centerY)
        case .trailing:
            if needPinHorizontally {
                pin(.flexibleLeading)
            }
            if needPinVertically {
                pin(.flexibleTop, .flexibleBottom)
            }
            pin(.trailing, .centerY)
        case .bottom:
            if needPinHorizontally {
                pin(.flexibleLeading, .flexibleTailing)
            }
            if needPinVertically {
                pin(.flexibleTop)
            }
            pin(.bottom, .centerX)
            
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
            if hasWidth {
                centerXAnchor == superview.centerXAnchor
            } else {
                leadingAnchor  == superview.leadingAnchor
                trailingAnchor == superview.trailingAnchor
            }
            bottomAnchor == superview.safeAreaLayoutGuide.topAnchor
            layoutIfNeeded()
            controller?.additionalSafeAreaInsets.top = bounds.height
        case .bottomBar:
            if hasWidth {
                centerXAnchor == superview.centerXAnchor
            } else {
                leadingAnchor  == superview.leadingAnchor
                trailingAnchor == superview.trailingAnchor
            }
            topAnchor == superview.safeAreaLayoutGuide.bottomAnchor
            layoutIfNeeded()
            controller?.additionalSafeAreaInsets.bottom = bounds.height
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
        
        enum AnchotAttribute {
            case top, leading, trailing, bottom, flexibleTop, flexibleLeading, flexibleTailing, flexibleBottom, centerX, centerY
        }
        
        func pin(_ attributes: AnchotAttribute...) {
            if let scrollView = superview as? UIScrollView {
                for attribute in attributes {
                    switch attribute {
                    case .top:
                        topAnchor == scrollView.frameLayoutGuide.topAnchor
                    case .leading:
                        leadingAnchor == scrollView.frameLayoutGuide.leadingAnchor
                    case .trailing:
                        trailingAnchor == scrollView.frameLayoutGuide.trailingAnchor
                    case .bottom:
                        bottomAnchor == scrollView.frameLayoutGuide.bottomAnchor
                    case .flexibleTop:
                        topAnchor >= scrollView.frameLayoutGuide.topAnchor
                    case .flexibleLeading:
                        leadingAnchor >= scrollView.frameLayoutGuide.leadingAnchor
                    case .flexibleTailing:
                        trailingAnchor <= scrollView.frameLayoutGuide.trailingAnchor
                    case .flexibleBottom:
                        bottomAnchor <= scrollView.frameLayoutGuide.bottomAnchor
                    case .centerX:
                        centerXAnchor == scrollView.frameLayoutGuide.centerXAnchor
                    case .centerY:
                        centerYAnchor == scrollView.frameLayoutGuide.centerYAnchor
                    }
                }
            } else {
                for attribute in attributes {
                    switch attribute {
                    case .top:
                        topAnchor == superview.topAnchor
                    case .leading:
                        leadingAnchor == superview.leadingAnchor
                    case .trailing:
                        trailingAnchor == superview.trailingAnchor
                    case .bottom:
                        bottomAnchor == superview.bottomAnchor
                    case .flexibleTop:
                        topAnchor >= superview.topAnchor
                    case .flexibleLeading:
                        leadingAnchor >= superview.leadingAnchor
                    case .flexibleTailing:
                        trailingAnchor <= superview.trailingAnchor
                    case .flexibleBottom:
                        bottomAnchor <= superview.bottomAnchor
                    case .centerX:
                        centerXAnchor == superview.centerXAnchor
                    case .centerY:
                        centerYAnchor == superview.centerYAnchor
                    }
                }
            }
        }
    }
}
