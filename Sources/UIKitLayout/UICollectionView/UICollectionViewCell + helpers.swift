//
//  UICollectionViewCell + helpers.swift
//
//  Created by Yevhen Biiak on 03.09.2023.
//

import UIKit

extension UICollectionReusableView: ReuseIdentifiable {}

extension UICollectionViewCell {
    
    public var indexPath: IndexPath? {
        if let collectionView = superview as? UICollectionView {
            return collectionView.indexPath(for: self)
        } else {
            return nil
        }
    }
}
