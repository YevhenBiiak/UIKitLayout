//
//  UIButton.Configuration + font.swift
//
//  Created by Yevhen Biiak on 24.09.2023.
//

import UIKit

extension UIButton.Configuration {
    
    /// Sets font to titleTextAttributesTransformer closure but always returns nil
    public var font: UIFont? {
        get { nil }
        set {
            titleTextAttributesTransformer = .init { incoming in
                var outgoing = incoming
                outgoing.font = newValue
                return outgoing
            }
        }
    }
}
