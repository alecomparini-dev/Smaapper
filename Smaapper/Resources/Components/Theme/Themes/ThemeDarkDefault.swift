//
//  ThemeDarkDefault.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/05/23.
//

import UIKit


struct ThemeDarkDefault: ThemeProtocol {
    
    var backgroundColor: UIColor { UIColor.HEX("#292D2E")}
    var backgroundColorGradient: [UIColor] { [backgroundColor, backgroundColor.adjustBrightness(-60)] }
    
    var primary: UIColor { UIColor.HEX("#ec9355") }
//    var primary: UIColor { UIColor.HEX("#ff935d") }
    var primaryGradient: [UIColor] { [primary, UIColor.HEX("#FF6517")] }
    var onPrimary:UIColor { UIColor.HEX("#0f1010") }
    
    var primaryContainer: UIColor {UIColor.HEX("#1F7799")}
    var onPrimaryContainer = UIColor.HEX("#FFFFFF")
    
    var secondary: UIColor { UIColor.HEX("#1a365b") }
    var secondaryGradient: [UIColor] { [secondary, UIColor.HEX("#ff6b00")] }
    var onSecondary = UIColor.HEX("#FFFFFF")
    var secondaryContainer: UIColor = .black
    var onSecondaryContainer: UIColor = .black
    
//    var tertiary: UIColor { UIColor.HEX("#f54336") }
    var tertiary: UIColor { UIColor.HEX("#ee6c29") }
    var tertiaryGradient: [UIColor] { [tertiary, UIColor.HEX("#ff6b00")] }
    var onTertiary: UIColor { UIColor.HEX("#0f1010") }
    var tertiaryContainer: UIColor = .black
    var onTertiaryContainer: UIColor = .black
    
    var surfaceContainerHighest: UIColor { UIColor.HEX("#41484a") }
    var surfaceContainerHigh: UIColor { surfaceContainerHighest.adjustBrightness(-25) }
    var surfaceContainer: UIColor { surfaceContainerHighest.adjustBrightness(-40) }
    var surfaceContainerLow: UIColor { surfaceContainerHighest.adjustBrightness(-60) }
    var surfaceContainerLowest: UIColor { surfaceContainerHighest.adjustBrightness(-70) }

    var onSurface: UIColor { UIColor.HEX("#d3d3d3") }
    var onSurfaceInverse: UIColor { UIColor.HEX("#050505") }
    var onSurfaceVariant: UIColor { onSurface.adjustBrightness(-40) }

}
