//
//  UIBezierPath + fixedRoundedRect.swift
//
//  Created by Yevhen Biiak on 23.04.2024.
//

import UIKit

extension UIBezierPath {
    internal static func fixedRoundedRect(rect: CGRect, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        // Move to the starting point
        path.move(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))
        // Add the top-right corner
        path.addArc(withCenter: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: CGFloat(-Double.pi / 2), endAngle: 0, clockwise: true)
        // Add the bottom-right corner
        path.addArc(withCenter: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        // Add the bottom-left corner
        path.addArc(withCenter: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: true)
        // Add the top-left corner and close the path
        path.addArc(withCenter: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(-Double.pi / 2), clockwise: true)
        // Close the path to complete the shape
        path.close()
        return path
    }
}
