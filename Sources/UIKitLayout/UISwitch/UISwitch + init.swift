//
//  UISwitch + init.swift
//
//  Created by Yevhen Biiak on 14.08.2023.
//

import UIKit
import Combine

extension UISwitch {
    
    public convenience init(_ isOn: Bool) {
        self.init(frame: .zero)
        self.isOn = isOn
    }
    
    public convenience init(_ publisher: Published<Bool>.Publisher) {
        self.init(frame: .zero)
        publisher.sink { [weak self] isOn in
            self?.isOn = isOn
        }.store(in: self)
    }
}
