//
//  StorableView.swift
//
//  Created by Yevhen Biiak on 21.08.2023.
//

import UIKit

public protocol StorableView {}

extension StorableView {
    @discardableResult
    public func store(in ref: inout Self?) -> Self {
        ref = self
        return self
    }
}

extension UIView: StorableView {}
