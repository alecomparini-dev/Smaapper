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
    
    @nonobjc class func HEX(_ hexColor: String) -> UIColor {
        return HEXA(hexColor, 1.0)
    }
    
}


extension String {
    func isHexColor() -> Bool {
        let hexColorRegex = "^#([0-9A-Fa-f]{6})$"
        return NSPredicate(format: "SELF MATCHES %@", hexColorRegex).evaluate(with: self)
    }
}
