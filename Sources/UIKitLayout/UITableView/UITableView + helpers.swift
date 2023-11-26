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
    ) -> Cell where Cell: UITableViewCell, Cell: ReuseIdentifiable {
        
        let cell: Cell! = dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell
        cell.indexPath = indexPath
        configurationHandler?(cell)
        
        return cell
    }
    
    public func diffableDataSource<S: Hashable, I: Hashable>(cellProvider: @escaping (UITableView, IndexPath, I) -> UITableViewCell?) ->  UITableViewDiffableDataSource<S,I> {
        return UITableViewDiffableDataSource<S,I>(tableView: self, cellProvider: cellProvider)
    }
}
