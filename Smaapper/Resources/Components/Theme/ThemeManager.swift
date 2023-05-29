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
    var primaryGradient: [UIColor] { get }
    var onPrimary: UIColor { get }
    var primaryContainer: UIColor { get }
    var onPrimaryContainer: UIColor { get }
    
    var secondary: UIColor { get }
    var secondaryGradient: [UIColor] { get }
    var onSecondary: UIColor { get }
    var secondaryContainer: UIColor { get }
    var onSecondaryContainer: UIColor { get }
    
    var tertiary: UIColor { get }
    var tertiaryGradient: [UIColor] { get }
    var onTertiary: UIColor { get }
    var tertiaryContainer: UIColor { get }
    var onTertiaryContainer: UIColor { get }
    
    var surfaceContainerLowest: UIColor { get }
    var surfaceContainerLow: UIColor { get }
    var surfaceContainer: UIColor { get }
    var surfaceContainerHigh: UIColor { get }
    var surfaceContainerHighest: UIColor { get }
    
    var onSurface: UIColor { get }
    var onSurfaceVariant: UIColor { get }
    var onSurfaceInverse: UIColor { get }
    
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
    var backgroundColorGradient: [UIColor] { [backgroundColor, backgroundColor.adjustBrightness(-60)] }
    
    var primary: UIColor { UIColor.HEX("#ec9355") }
    var primaryGradient: [UIColor] { [primary, UIColor.HEX("#ff6b00")] }
    var onPrimary:UIColor { UIColor.HEX("#0f1010") }
    
    var primaryContainer: UIColor {UIColor.HEX("#3d4248")}
    var onPrimaryContainer = UIColor.HEX("#FFFFFF")
    
    var secondary: UIColor { UIColor.HEX("#3d4248") }
    var secondaryGradient: [UIColor] { [secondary, UIColor.HEX("#ff6b00")] }
    var onSecondary = UIColor.HEX("#FFFFFF")
    var secondaryContainer: UIColor = .black
    var onSecondaryContainer: UIColor = .black
    
    var tertiary: UIColor = .black
    var tertiaryGradient: [UIColor] { [tertiary, UIColor.HEX("#ff6b00")] }
    var onTertiary: UIColor = .black
    var tertiaryContainer: UIColor = .black
    var onTertiaryContainer: UIColor = .black
    
    var surfaceContainerHighest: UIColor { UIColor.HEX("#41484a") }
    var surfaceContainerHigh: UIColor { surfaceContainerHighest.adjustBrightness(-20) }
    var surfaceContainer: UIColor { surfaceContainerHighest.adjustBrightness(-40) }
    var surfaceContainerLow: UIColor { surfaceContainerHighest.adjustBrightness(-60) }
    var surfaceContainerLowest: UIColor { surfaceContainerHighest.adjustBrightness(-70) }

    var onSurface: UIColor { UIColor.HEX("#d3d3d3") }
    var onSurfaceInverse: UIColor { UIColor.HEX("#050505") }
    var onSurfaceVariant: UIColor { onSurface.adjustBrightness(-40) }//9598a0

}


struct ThemeLightDefault {
    var onPrimaryColor: UIColor
    var backgroundColorGradient: [UIColor]
    var primaryColor: UIColor
    var backgroundColor: UIColor = .white
}
