//
//  UIButton + init.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit
import Combine

extension UIButton {
    
    private struct UKLAssociatedKeys {
        static var _backgroundColor  = "_backgroundColor_"
        static var _foregroundColor  = "_foregroundColor_"
        static var _isStrokeColorAdded  = "_isStrokeColorAdded_"
    }
    
    internal var _backgroundColors: [UInt: UIColor] {
        get { getAssociatedObject(key: &UKLAssociatedKeys._backgroundColor) ?? [:] }
        set { setAssociatedObject(key: &UKLAssociatedKeys._backgroundColor, value: newValue) }
    }
    
    internal var _foregroundColors: [UInt: UIColor] {
        get { getAssociatedObject(key: &UKLAssociatedKeys._foregroundColor) ?? [:] }
        set { setAssociatedObject(key: &UKLAssociatedKeys._foregroundColor, value: newValue) }
    }
    
    internal var _isStrokeColorAdded: Bool {
        get { getAssociatedObject(key: &UKLAssociatedKeys._isStrokeColorAdded) ?? false }
        set { setAssociatedObject(key: &UKLAssociatedKeys._isStrokeColorAdded, value: newValue) }
    }
    
    public convenience init(_ title: String) {
        self.init(configuration: .filled())
        configuration?.title = title
    }
    
    public convenience init(image: UIImage) {
        self.init(configuration: .filled())
        configuration?.image = image
    }
    
    public convenience init(_ title: String, image: UIImage) {
        self.init(configuration: .filled())
        configuration?.title = title
        configuration?.image = image
    }
    
    public convenience init(_ publisher: Published<String>.Publisher) {
        self.init(configuration: .filled())
        publisher.sink { [weak self] title in
            self?.configuration?.title = title
        }
        .store(in: self)
    }
    
    public convenience init(_ publisher: Published<String>.Publisher, image: UIImage) {
        self.init(configuration: .filled())
        publisher.sink { [weak self] title in
            self?.configuration?.title = title
        }
        .store(in: self)
        configuration?.image = image
    }
}
