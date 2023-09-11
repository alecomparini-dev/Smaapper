//
//  UIColor+Extension+Component.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 23/03/23.
//

import UIKit

extension UIColor {
    
    @nonobjc class func RGBA(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Float) -> UIColor {
        return UIColor(red: red.toCGFloat/255, green: green.toCGFloat/255, blue: blue.toCGFloat/255, alpha: alpha.toCGFloat )
    }
    
    @nonobjc class func RGB(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        return RGBA(red, green, blue, 1.0 )
    }
    
    @nonobjc class func HEXA(_ hexColor: String, _ alpha: Float) -> UIColor {
        if !hexColor.isHexColor() {
            preconditionFailure("\(hexColor) not a valid hex color !")
        }
        
        var hexString = hexColor.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0x00ff00) >> 8
        let b = (rgbValue & 0x0000ff)

        return UIColor.RGBA(Int(r), Int(g), Int(b), alpha)

    }
    
    @nonobjc class func HEX(_ hexColor: String, _ alpha: Float) -> UIColor {
        return HEXA(hexColor, alpha)
    }
    
    @nonobjc class func HEX(_ hexColor: String) -> UIColor {
        return HEXA(hexColor, 1.0)
    }
    
    
    var toHexString: String {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return "#000000" // Retorna preto como valor padrão se não for possível obter os componentes RGB
        }
        
        let r = max(0, min(255, Int(components[0] * 255.0)))
        let g = max(0, min(255, Int(components[1] * 255.0)))
        let b = max(0, min(255, Int(components[2] * 255.0)))
        
        return String(format: "#%02X%02X%02X", r, g, b)
        
    }
    
    
    func adjustBrightness(_ percentage: CGFloat) -> UIColor {
        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0, alpha: CGFloat = 0.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        let newBrightness = brightness * (1 + (percentage/100))
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    
    
}


extension String {
    func isHexColor() -> Bool {
        let hexColorRegex = "^#([0-9A-Fa-f]{6})$"
        return NSPredicate(format: "SELF MATCHES %@", hexColorRegex).evaluate(with: self)
    }
    
}
