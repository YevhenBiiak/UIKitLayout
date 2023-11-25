//
//  UITableViewCell + helpers.swift
//
//  Created by Yevhen Biiak on 02.09.2023.
//

import UIKit

extension UITableViewCell: ReuseIdentifiable {}

extension UITableViewCell {
    
    public var indexPath: IndexPath {
        if let tableView = superview as? UITableView,
           let indexPath = tableView.indexPath(for: self) {
            return indexPath
        } else {
            return IndexPath(item: 0, section: 0)
        }
    }
}
