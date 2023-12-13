//
//  UITableViewCell + helpers.swift
//
//  Created by Yevhen Biiak on 02.09.2023.
//

import UIKit

extension UITableViewCell: ReuseIdentifiable {}

extension UITableViewCell {
    
    private struct AssociatedKeys {
        static var indexPath = "UIKitLayout_indexPath"
    }
    
    @available(*, deprecated, message: "Might cause unexpected results. Create your own indexPath property and pass it manually")
    public var indexPath: IndexPath {
        get {
            let indexPath: IndexPath? = getAssociatedObject(key: &AssociatedKeys.indexPath)
            if let indexPath {
                return indexPath
            } else {
                fatalError("if you want to use indexPath property use dequeueReusableCell<Cell> generic method")
            }
        }
        set { setAssociatedObject(key: &AssociatedKeys.indexPath, value: newValue) }
    }
}
