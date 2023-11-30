//
//  UICollectionView + helpers.swift
//
//  Created by Yevhen Biiak on 29.08.2023.
//

import UIKit

extension UICollectionView {
    
    public func dequeueReusableCell<Cell>(
        _ type: Cell.Type,
        for indexPath: IndexPath,
        configurationHandler: (_ cell: Cell) -> Void = {_ in}
    ) -> Cell where Cell: UICollectionViewCell, Cell: ReuseIdentifiable {
        
        let cell: Cell! = dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell
        cell.indexPath = indexPath
        configurationHandler(cell)
        
        return cell
    }
    
    public func diffableDataSource<S: Hashable, I: Hashable>(cellProvider: @escaping (UICollectionView, IndexPath, I) -> UICollectionViewCell?) -> UICollectionViewDiffableDataSource<S,I> {
        return UICollectionViewDiffableDataSource<S,I>(collectionView: self, cellProvider: cellProvider)
    }
    
    public func diffableDataSource<Cell, S: Hashable, I: Hashable>(
        using cell: Cell.Type,
        handler: @escaping (_ cell: Cell, _ indexPath: IndexPath, _ item: I) -> Void
    ) -> UICollectionViewDiffableDataSource<S,I> where Cell: UICollectionViewCell, Cell: ReuseIdentifiable {
        
        diffableDataSource { (collectionView, indexPath, item) in
            collectionView.dequeueReusableCell(Cell.self, for: indexPath) { cell in
                handler(cell, indexPath, item)
            }
        }
    }
}
