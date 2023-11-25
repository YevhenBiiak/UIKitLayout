//
//  UITableViewCell + helpers.swift
//
//  Created by Yevhen Biiak on 02.09.2023.
//

import UIKit

extension UITableViewCell: ReuseIdentifiable {}

extension UITableViewCell {
    
    public var indexPath: IndexPath? {
        if let tableView = superview as? UITableView {
            return tableView.indexPath(for: self)
        } else {
            return nil
        }
    }
}
