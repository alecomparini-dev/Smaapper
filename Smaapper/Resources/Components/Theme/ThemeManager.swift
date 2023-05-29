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
    var primary: UIColor { get }
    var onPrimary: UIColor { get }
    var primaryContainer: UIColor { get }
    var onPrimaryContainer: UIColor { get }
    var secondary: UIColor { get }
    var onSecondary: UIColor { get }
    var secondaryContainer: UIColor { get }
    var onSecondaryContainer: UIColor { get }
    var tertiary: UIColor { get }
    var onTertiary: UIColor { get }
    var tertiaryContainer: UIColor { get }
    var onTertiaryContainer: UIColor { get }
    
    var surfaceContainerLowest: UIColor { get }
    var surfaceContainerLow: UIColor { get }
    var surfaceContainer: UIColor { get }
    var surfaceContainerHigh: UIColor { get }
    var surfaceContainerHighest: UIColor { get }
    
    
    
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
    var backgroundColorGradient: [UIColor] { return [backgroundColor, backgroundColor.adjustBrightness(-60)] }
    
    var primary: UIColor {UIColor.HEX("#3d4248")}
    var onPrimary = UIColor.HEX("#FFFFFF")
    
    var primaryContainer: UIColor {UIColor.HEX("#3d4248")}
    var onPrimaryContainer = UIColor.HEX("#FFFFFF")
    
    
    var secondary: UIColor { UIColor.HEX("#3d4248") }
    var onSecondary = UIColor.HEX("#FFFFFF")
    
    var secondaryContainer: UIColor = .black
    var onSecondaryContainer: UIColor = .black
    
    
    var tertiary: UIColor = .black
    var onTertiary: UIColor = .black
    
    var tertiaryContainer: UIColor = .black
    var onTertiaryContainer: UIColor = .black
    
    
    var surfaceContainerHighest: UIColor { UIColor.HEX("#41484a") }
    var surfaceContainerHigh: UIColor { surfaceContainerHighest.adjustBrightness(-20) }
    var surfaceContainer: UIColor { surfaceContainerHighest.adjustBrightness(-40) }
    var surfaceContainerLow: UIColor { surfaceContainerHighest.adjustBrightness(-55) }
    var surfaceContainerLowest: UIColor { surfaceContainerHighest.adjustBrightness(-70) }
    
}


struct ThemeLightDefault {
    var onPrimaryColor: UIColor
    var backgroundColorGradient: [UIColor]
    var primaryColor: UIColor
    var backgroundColor: UIColor = .white
}
