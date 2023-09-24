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
        configurationHandler: ((_ cell: Cell) -> Void)? = nil
    ) -> UICollectionViewCell where Cell: UICollectionViewCell, Cell: ReuseIdentifiable {
        
        let cell: Cell! = dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell
        cell.indexPath = indexPath
        configurationHandler?(cell)
        
        return cell
    }
    
    public func diffableDataSource<S: Hashable, I: Hashable>(cellProvider: @escaping (UICollectionView, IndexPath, I) -> UICollectionViewCell?) -> UICollectionViewDiffableDataSource<S,I> {
        return UICollectionViewDiffableDataSource<S,I>(collectionView: self, cellProvider: cellProvider)
    }
    
    public func registerCell<Cell>(_ type: Cell.Type) where Cell: UICollectionViewCell, Cell: ReuseIdentifiable {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseId)
    }
    
    public func registerCellWithNib<Cell>(_ type: Cell.Type) where Cell: UICollectionViewCell, Cell: ReuseIdentifiable {
        let nib = UINib(nibName: Cell.reuseId, bundle: nil)
        register(nib, forCellWithReuseIdentifier: Cell.reuseId)
    }
}
