//
//  ReuseIdentifiable.swift
//
//  Created by Yevhen Biiak on 03.09.2023.
//

import UIKit

public protocol ReuseIdentifiable: AnyObject {}

extension ReuseIdentifiable {
    public static var reuseId: String {
        String(describing: self)
    }
}
