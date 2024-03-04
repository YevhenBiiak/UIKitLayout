//
//  UIImage + resize, alpha.swift
//
//  Created by Yevhen Biiak on 14.12.2023.
//

import UIKit

extension UIImage {
    
    public func resize(fitIn length: CGFloat) -> UIImage? {
        let aspectRatio = min(length / size.width, length / size.height)
        let width = size.width * aspectRatio
        let height = size.height * aspectRatio
        return resize(width: width, height: height)
    }
    
    public func resize(scale: CGFloat) -> UIImage? {
        resize(width: size.width * scale, height: size.height * scale)
    }
    
    public func resize(width: CGFloat, height: CGFloat) -> UIImage? {
        resize(to: .init(width: width, height: height))
    }
    
    public func resize(to size: CGSize) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public func withAlphaComponent(_ alpha: CGFloat) -> UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
