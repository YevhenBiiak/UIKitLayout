//
//  Button.swift
//
//  Created by Yevhen Biiak on 13.08.2023.
//

import UIKit
import Combine

extension UIButton {
    
    public convenience init(_ title: String) {
        self.init(configuration: .filled())
        configuration?.title = title
    }
    
    public convenience init(image: UIImage) {
        self.init(configuration: .filled())
        configuration?.image = image
    }
    
    public convenience init(_ title: String, image: UIImage) {
        self.init(configuration: .filled())
        configuration?.title = title
        configuration?.image = image
    }
    
    public convenience init(_ title: Published<String>.Publisher) {
        self.init(configuration: .filled())
        title.sink { [weak self] title in
            self?.configuration?.title = title
        }
        .store(in: self)
    }
}
