//
//  UISearchBar + init.swift
//
//  Created by Yevhen Biiak on 17.09.2023.
//

import UIKit

extension UISearchBar {
    
    public convenience init(_ placeholder: String) {
        self.init()
        self.backgroundImage = UIImage()
        self.placeholder = placeholder
    }
}
