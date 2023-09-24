//
//  UITableView + helpers.swift
//
//  Created by Yevhen Biiak on 02.09.2023.
//

import UIKit

extension UITableView {
    
    public func dequeueReusableCell<Cell>(
        _ type: Cell.Type,
        for indexPath: IndexPath,
        configurationHandler: ((_ cell: Cell) -> Void)? = nil
    ) -> UITableViewCell where Cell: UITableViewCell, Cell: ReuseIdentifiable {
        
        let cell: Cell! = dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell
        cell.indexPath = indexPath
        configurationHandler?(cell)
        
        return cell
    }
    
    public func diffableDataSource<S: Hashable, I: Hashable>(cellProvider: @escaping (UITableView, IndexPath, I) -> UITableViewCell?) ->  UITableViewDiffableDataSource<S,I> {
        return UITableViewDiffableDataSource<S,I>(tableView: self, cellProvider: cellProvider)
    }
    
    public func registerCell<Cell>(_ type: Cell.Type) where Cell: UITableViewCell, Cell: ReuseIdentifiable {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseId)
    }
    
    public func registerCellWithNib<Cell>(_ type: Cell.Type) where Cell: UITableViewCell, Cell: ReuseIdentifiable {
        let nib = UINib(nibName: Cell.reuseId, bundle: nil)
        register(nib, forCellReuseIdentifier: Cell.reuseId)
    }
}
