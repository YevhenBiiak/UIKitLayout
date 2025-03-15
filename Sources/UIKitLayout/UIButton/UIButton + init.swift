//
//  UIButton + init.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit
import Combine

extension UIButton {
    
    public struct UKLAlphaConfig {
        var normal: CGFloat
        var disabled: CGFloat
        var highlighted: CGFloat
        public init(normal: CGFloat = 1.0, disabled: CGFloat = 0.3, highlighted: CGFloat = 0.4) {
            self.normal = normal
            self.disabled = disabled
            self.highlighted = highlighted
        }
    }
    
    private struct UKLAssociatedKeys {
        static var _imageSpacing = "_imageSpacing"
        static var _contentInsets = "_contentInsets"
        static var _imagePlacement = "_imagePlacement"
    }
    
    internal var _imageSpacing: CGFloat {
        get { getAssociatedObject(key: &UKLAssociatedKeys._imageSpacing) ?? 0 }
        set { setAssociatedObject(key: &UKLAssociatedKeys._imageSpacing, value: newValue) }
    }
    
    internal var _contentInsets: UIEdgeInsets {
        get { getAssociatedObject(key: &UKLAssociatedKeys._contentInsets) ?? .zero }
        set { setAssociatedObject(key: &UKLAssociatedKeys._contentInsets, value: newValue) }
    }
    
    internal var _imagePlacement: UKLImagePlacement {
        get { getAssociatedObject(key: &UKLAssociatedKeys._imagePlacement) ?? .leading }
        set { setAssociatedObject(key: &UKLAssociatedKeys._imagePlacement, value: newValue) }
    }
    
    public convenience init(_ title: String, type: ButtonType = .system) {
        self.init(type: type)
        self.setTitle(title, for: .normal)
    }
    
    public convenience init(type: ButtonType = .system, alphaConfig: UKLAlphaConfig = .init(), content: () -> UIView) {
        self.init(type: type)
        let content = content()
        self.subview(.center) {
            content.userInteractionEnabled(false)
        }
        super.onChange(\.isEnabled) { [weak self, weak content] isEnabled in
            if let self, isEnabled {
                content?.alpha = isHighlighted ? alphaConfig.highlighted : 1.0
            } else {
                content?.alpha = alphaConfig.disabled
            }
        }
        super.onChange(\.isHighlighted) { [weak self, weak content] isHighlighted in
            if let self, isEnabled {
                content?.alpha = isHighlighted ? alphaConfig.highlighted : 1.0
            } else {
                content?.alpha = alphaConfig.disabled
            }
        }
    }
    
    public convenience init(image: UIImage, type: ButtonType = .custom) {
        self.init(type: type)
        self.setImage(image, for: .normal)
    }
    
    public convenience init(_ title: String, image: UIImage, type: ButtonType = .custom) {
        self.init(type: type)
        self.setTitle(title, for: .normal)
        self.setImage(image, for: .normal)
    }
    
    // public convenience init(_ publisher: Published<String>.Publisher) {
    //     self.init()
    //     self.validateConfiguration()
    //     publisher.sink { [weak self] title in
    //         self?.configuration?.title = title
    //     }
    //     .store(in: self)
    // }
    // 
    // public convenience init(_ publisher: Published<String>.Publisher, image: UIImage) {
    //     self.init()
    //     self.validateConfiguration()
    //     self.configuration?.image = image
    //     _iconImages[UIButton.State.normal.rawValue] = image
    //     publisher.sink { [weak self] title in
    //         self?.configuration?.title = title
    //     }
    //     .store(in: self)
    // }
}
