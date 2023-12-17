//
//  UIViewController + isPad, isPhone.swift
//
//  Created by Yevhen Biiak on 10.10.2023.
//

import UIKit

extension UIViewController {
    
    public var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
