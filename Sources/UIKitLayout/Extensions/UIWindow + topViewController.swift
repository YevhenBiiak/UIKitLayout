//
//  UIWindow + topViewController.swift
//
//
//  Created by Yevhen Biiak on 16.11.2023.
//

import UIKit

extension UIWindow {
    
    public var topViewController: UIViewController? {
        var top = rootViewController
        
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            }
            else if let nav = top as? UINavigationController {
                top = nav.topViewController
            }
            else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            }
            else {
                break
            }
        }
        return top
    }
}
