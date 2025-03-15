//
//  UIButton + extensions.swift
//  Playground
//
//  Created by Yevhen Biiak on 18.08.2023.
//

import UIKit


extension UIButton {
    
    public enum UKLImagePlacement {
        case leading, trailing
    }
    
    @discardableResult
    public func backgroundColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        setBackgroundColor(color, for: state)
        return self
    }
    
    @discardableResult
    public func title(_ title: String, for state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }
    
    @discardableResult
    public func titleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    public func titleAlignment(_ alignment: NSTextAlignment) -> Self {
        titleLabel?.textAlignment = alignment
        return self
    }
    
    @discardableResult
    public func titleLineBrakeMode(_ mode: NSLineBreakMode) -> Self {
        self.titleLabel?.lineBrakeMode(mode)
        return self
    }
    
    @discardableResult
    public func image(_ image: UIImage, for state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    
    @discardableResult
    public func imagePlacement(_ placement: UKLImagePlacement) -> Self {
        self._imagePlacement = placement
        self.updateAppearance()
        return self
    }
    
    @discardableResult
    public func imageSpacing(_ spacing: CGFloat) -> Self {
        self._imageSpacing = spacing
        self.updateAppearance()
        return self
    }
    
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }
    
    @discardableResult
    public func enabled(_ enabled: Bool) -> Self {
        isEnabled = enabled
        return self
    }
    
    @discardableResult
    public func adjustFontSize(minScale: CGFloat?) -> Self {
        titleLabel?.adjustFontSize(minScale: minScale)
        return self
    }
    
    @discardableResult
    public func contentAlignment(horizontal alignment: UIControl.ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = alignment
        self.updateAppearance()
        return self
    }
    
    @discardableResult
    public func contentAlignment(vertical alignment: UIControl.ContentVerticalAlignment) -> Self {
        contentVerticalAlignment = alignment
        self.updateAppearance()
        return self
    }
    
    @discardableResult
    public func contentInsets(_ insets: UIEdgeInsets) -> Self {
        self._contentInsets = insets
        self.updateAppearance()
        return self
    }
    
    @discardableResult
    public func contentInsets(_ inset: CGFloat) -> Self {
        self._contentInsets = .init(top: inset, left: inset, bottom: inset, right: inset)
        self.updateAppearance()
        return self
    }
    
    @discardableResult
    public func contentInsets(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        if top == nil, left == nil, bottom == nil, right == nil {
            self._contentInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        } else {
            if let top    { self._contentInsets.top = top }
            if let left   { self._contentInsets.left = left }
            if let bottom { self._contentInsets.bottom = bottom }
            if let right  { self._contentInsets.right = right }
        }
        self.updateAppearance()
        return self
    }
    
    @discardableResult
    public func contentInsets(_ axis: NSLayoutConstraint.Axis, _ inset: CGFloat) -> UIView {
        switch axis {
        case .horizontal:
            self._contentInsets.left = inset
            self._contentInsets.right = inset
        case .vertical:
            self._contentInsets.top = inset
            self._contentInsets.bottom = inset
        @unknown default:
            break
        }
        self.updateAppearance()
        return self
    }
}


extension UIButton {
    private func updateAppearance() {
        guard let imageViewSize = imageView?.bounds.size,
              let titleLabelSize = titleLabel?.bounds.size
        else { return }
        
        let titleWidth = titleLabel?.text == nil ? 0 : titleLabelSize.width
        let placement = _imagePlacement
        let insets = _contentInsets
        let space = (imageView?.image == nil || titleLabel?.text == nil) ? 0 : _imageSpacing
        
        switch contentHorizontalAlignment {
        case .left, .leading:
            switch placement {
            case .leading:
                titleEdgeInsets = UIEdgeInsets(left: space, right: -space)
                imageEdgeInsets = .zero
                contentEdgeInsets = UIEdgeInsets(left: insets.left, right: insets.right + space)
            case .trailing:
                titleEdgeInsets = UIEdgeInsets(left: -(imageViewSize.width + space))
                imageEdgeInsets = UIEdgeInsets(left: titleWidth, right: -titleWidth)
                contentEdgeInsets = UIEdgeInsets(left: insets.left + space, right: insets.right)
            }
        case .right, .trailing:
            switch placement {
            case .leading:
                titleEdgeInsets = UIEdgeInsets(left: space, right: -space)
                imageEdgeInsets = .zero
                contentEdgeInsets = UIEdgeInsets(left: insets.left, right: insets.right + space)
            case .trailing:
                titleEdgeInsets = UIEdgeInsets(left: -2 * (imageViewSize.width + space), right: imageViewSize.width + space)
                imageEdgeInsets = UIEdgeInsets(left: titleWidth, right: -titleWidth)
                contentEdgeInsets = UIEdgeInsets(left: insets.left + space, right: insets.right)
            }
        case .fill:
            contentHorizontalAlignment = .center
            fallthrough
        default: // unknown or center, fill
            switch _imagePlacement {
            case .leading:
                titleEdgeInsets = UIEdgeInsets(left: space, right: -space)
                imageEdgeInsets = .zero
                contentEdgeInsets = UIEdgeInsets(left: insets.left, right: insets.right + space)
            case .trailing:
                titleEdgeInsets = UIEdgeInsets(left: -2 * (imageViewSize.width + space))
                imageEdgeInsets = UIEdgeInsets(left: titleWidth, right: -titleWidth)
                contentEdgeInsets = UIEdgeInsets(left: insets.left + space, right: insets.right)
            }
        }
    }
}

extension UIEdgeInsets {
    init(left: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
}

extension CGSize {
    var aspectRatio: CGFloat {
        width / height
    }
}
