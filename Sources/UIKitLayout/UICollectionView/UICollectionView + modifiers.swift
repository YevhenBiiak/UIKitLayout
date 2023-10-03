//
//  UICollectionView + modifiers.swift
//  Playground1
//
//  Created by Yevhen Biiak on 28.08.2023.
//

import UIKit

extension UICollectionView {
    
    @discardableResult
    public func dataSource(_ dataSource: UICollectionViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult
    public func delegate(_ delegate: UICollectionViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func allowSelection(_ enable: Bool) -> Self {
        allowsSelection = enable
        return self
    }
    
    @discardableResult
    public func allowFocus(_ enable: Bool) -> Self {
        allowsFocus = enable
        return self
    }
    
    @discardableResult
    public func registerCell<Cell>(_ type: Cell.Type) -> Self where Cell: UICollectionViewCell, Cell: ReuseIdentifiable {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseId)
        return self
    }
    
    @discardableResult
    public func registerCellWithNib<Cell>(_ type: Cell.Type) -> Self where Cell: UICollectionViewCell, Cell: ReuseIdentifiable {
        let nib = UINib(nibName: Cell.reuseId, bundle: nil)
        register(nib, forCellWithReuseIdentifier: Cell.reuseId)
        return self
    }
}
