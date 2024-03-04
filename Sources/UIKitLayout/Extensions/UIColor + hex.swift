//
//  UIColor + .swift
//
//  Created by Yevhen Biiak on 16.08.2023.
//

import UIKit

extension UIColor {
    
    public convenience init(hex: Int) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 0xFF
        let g = CGFloat((hex & 0x00FF00) >>  8) / 0xFF
        let b = CGFloat((hex & 0x0000FF) >>  0) / 0xFF
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    public convenience init(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if hex.hasPrefix("#") { hex.removeFirst() }
        
        if hex.count == 8 {
            let int = Int(hex, radix: 16)!
            let r = CGFloat((int & 0xFF000000) >> 24) / 0xFF
            let g = CGFloat((int & 0x00FF0000) >> 16) / 0xFF
            let b = CGFloat((int & 0x0000FF00) >>  8) / 0xFF
            let a = CGFloat((int & 0x000000FF) >>  0) / 0xFF
            self.init(red: r, green: g, blue: b, alpha: a.rounded(to: 2))
        }
        else if hex.count == 6 {
            self.init(hex: Int(hex, radix: 16)!)
        }
        else {
            // return black color for wrong hex input
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    public var alpha: CGFloat {
        rgba.a
    }
    
    public var rgb: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        (rgba.r, rgba.g, rgba.b)
    }
    
    public var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) = (0, 0, 0, 0)
        getHue(&(hsba.h), saturation: &(hsba.s), brightness: &(hsba.b), alpha: &(hsba.a))
        return hsba
    }
    
    public var hex: String {
        let components = [rgba.r, rgba.g, rgba.b, rgba.a]
        return components[0..<(alpha < 1 ? 4 : 3)]
            .map { String(format: "%02lX", Int($0 * 255)) }
            .reduce("#", +)
    }
    
    public var adaptiveTextColor: UIColor {
        isLightColor ? .black : .white
    }
    
    public var isLightColor: Bool {
        let lightRed   = rgb.red   > 0.65
        let lightGreen = rgb.green > 0.65
        let lightBlue  = rgb.blue  > 0.65
        
        let lightness = [lightRed, lightGreen, lightBlue].reduce(0) { $1 ? $0 + 1 : $0 }
        return lightness >= 2
    }
}

extension UIColor {
    internal var rgba: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var rgba: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) = (0, 0, 0, 0)
        getRed(&(rgba.r), green: &(rgba.g), blue: &(rgba.b), alpha: &(rgba.a))
        return rgba
    }
}

extension CGFloat {
    
    func rounded(to places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
}
