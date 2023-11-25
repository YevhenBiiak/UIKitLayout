//
//  UICollectionViewCell + helpers.swift
//
//  Created by Yevhen Biiak on 03.09.2023.
//

import UIKit

extension UICollectionReusableView: ReuseIdentifiable {}

extension UICollectionViewCell {
    
    private struct AssociatedKeys {
        static var indexPath = "indexPath"
    }
    
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
