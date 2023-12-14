//
//  UITableViewDiffableDataSource + helpers.swift
//
//  Created by Yevhen Biiak on 19.09.2023.
//

import UIKit

extension UITableViewDiffableDataSource {
    
    public func reload(items: [ItemIdentifierType]) where SectionIdentifierType == Int {
        var snapshot = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        applySnapshotUsingReloadData(snapshot)
    }
    
    public func apply(items: [ItemIdentifierType], animate: Bool = true) where SectionIdentifierType == Int {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ItemIdentifierType>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        apply(snapshot, animatingDifferences: animate)
    }
}
