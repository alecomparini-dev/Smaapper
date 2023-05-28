//
//  ThemeManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/05/23.
//

import UIKit

protocol ThemeStrategy {
    var backgroundColor: UIColor { get }
    var backgroundColorGradient: [UIColor] { get }
    var primaryColor: UIColor { get }
    var onPrimaryColor: UIColor { get }
}


class Theme {
    static let shared = Theme()
    
    var currentTheme: ThemeStrategy
    
    private init() {
        self.currentTheme = ThemeDarkDefault()
    }
    
    static func setTheme(_ theme: ThemeStrategy) {
        Theme.shared.currentTheme = theme
    }
    
}

struct ThemeDarkDefault: ThemeStrategy {
    var backgroundColor: UIColor { UIColor.HEX("#292D2E") }
    var backgroundColorGradient: [UIColor] { return [backgroundColor, backgroundColor.adjustBrightness(-10)] }
    var primaryColor: UIColor {UIColor.HEX("#3d4248")}
    var onPrimaryColor = UIColor.HEX("#FFFFFF")
    
}


struct ThemeLightDefault: ThemeStrategy {
    var onPrimaryColor: UIColor
    var backgroundColorGradient: [UIColor]
    var primaryColor: UIColor
    var backgroundColor: UIColor = .white
}
