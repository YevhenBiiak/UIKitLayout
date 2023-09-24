//
//  UIDevice + .swift
//
//  Created by Yevhen Biiak on 22.09.2023.
//

import UIKit

extension UIDevice {
    public var isIPad: Bool {
        userInterfaceIdiom == .pad
    }
    public var isIPhone: Bool {
        userInterfaceIdiom == .phone
    }
}
