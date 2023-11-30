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
        configurationHandler: (_ cell: Cell) -> Void = {_ in}
    ) -> Cell where Cell: UITableViewCell, Cell: ReuseIdentifiable {
        
        let cell: Cell! = dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell
        cell.indexPath = indexPath
        configurationHandler(cell)
        
        return cell
    }
    
    public func diffableDataSource<S: Hashable, I: Hashable>(cellProvider: @escaping (UITableView, IndexPath, I) -> UITableViewCell?) ->  UITableViewDiffableDataSource<S,I> {
        return UITableViewDiffableDataSource<S,I>(tableView: self, cellProvider: cellProvider)
    }
    
    public func diffableDataSource<Cell, S: Hashable, I: Hashable>(
        using cell: Cell.Type,
        handler: @escaping (_ cell: Cell, _ indexPath: IndexPath, _ item: I) -> Void
    ) -> UITableViewDiffableDataSource<S,I> where Cell: UITableViewCell, Cell: ReuseIdentifiable {
        
        diffableDataSource { (tableView, indexPath, item) in
            tableView.dequeueReusableCell(Cell.self, for: indexPath) { cell in
                handler(cell, indexPath, item)
            }
        }
    }
}
