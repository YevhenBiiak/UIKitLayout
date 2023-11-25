//
//  UICollectionViewCell + helpers.swift
//
//  Created by Yevhen Biiak on 03.09.2023.
//

import UIKit

extension UICollectionReusableView: ReuseIdentifiable {}

extension UICollectionViewCell {
    
    public var indexPath: IndexPath {
        if let collectionView = superview as? UICollectionView,
           let indexPath = collectionView.indexPath(for: self) {
            return indexPath
        } else {
            return IndexPath(item: 0, section: 0)
        }
    }
}
