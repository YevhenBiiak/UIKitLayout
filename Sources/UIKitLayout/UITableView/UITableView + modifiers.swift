//
//  UITableView + modifiers.swift
//
//  Created by Yevhen Biiak on 27.08.2023.
//

import UIKit

extension UITableView {
    
    @discardableResult
    public func separatorInsets(_ insets: UIEdgeInsets) -> Self {
        separatorInset = insets
        return self
    }
    
    @discardableResult
    public func separatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
        separatorStyle = style
        return self
    }
    
    @discardableResult
    public func separatorColor(_ color: UIColor?) -> Self {
        separatorColor = color
        return self
    }
    
    @discardableResult
    public func dataSource(_ dataSource: UITableViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult
    public func delegate(_ delegate: UITableViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    public func allowsSelection(_ enable: Bool) -> Self {
        allowsSelection = enable
        return self
    }
    
    @discardableResult
    public func allowsFocus(_ enabled: Bool) -> Self {
        allowsFocus = enabled
        return self
    }
    
    @discardableResult
    public func rowHeight(_ rowHeight: CGFloat) -> Self {
        self.rowHeight = rowHeight
        return self
    }
    
    @discardableResult
    public func registerCell<Cell>(_ type: Cell.Type) -> Self where Cell: UITableViewCell, Cell: ReuseIdentifiable {
        register(Cell.self, forCellReuseIdentifier: Cell.reuseId)
        return self
    }
    
    @discardableResult
    public func registerCellWithNib<Cell>(_ type: Cell.Type) -> Self where Cell: UITableViewCell, Cell: ReuseIdentifiable {
        let nib = UINib(nibName: Cell.reuseId, bundle: nil)
        register(nib, forCellReuseIdentifier: Cell.reuseId)
        return self
    }
}
