//
//  UICollectionViewDiffableDataSource + helpers.swift
//
//  Created by Yevhen Biiak on 19.09.2023.
//

import UIKit

extension UICollectionViewDiffableDataSource {
    
    public func reload(items: [ItemIdentifierType]) where SectionIdentifierType == Int {
        var snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        applySnapshotUsingReloadData(snapshot)
    }
}
