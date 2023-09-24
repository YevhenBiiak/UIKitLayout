//
//  UILabel + properties.swift
//
//  Created by Yevhen Biiak on 19.08.2023.
//

import UIKit
import Combine

extension UILabel {
    
    public convenience init(_ text: String) {
        self.init(frame: .zero)
        self.text = text
    }
    
    public convenience init(_ text: Published<String>.Publisher) {
        self.init(frame: .zero)
        text.sink { [weak self] text in
            self?.text = text
        }
        .store(in: self)
    }
}
