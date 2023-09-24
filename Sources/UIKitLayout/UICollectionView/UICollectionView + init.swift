//
//  UICollectionView.swift
//
//  Created by Yevhen Biiak on 28.08.2023.
//

import UIKit

extension UICollectionView {
    
    public convenience init(_ flowLayout: (_ flowLayout: UICollectionViewFlowLayout) -> Void) {
        let layout = UICollectionViewFlowLayout()
        flowLayout(layout)
        self.init(frame: .zero, collectionViewLayout: layout)
    }
}
