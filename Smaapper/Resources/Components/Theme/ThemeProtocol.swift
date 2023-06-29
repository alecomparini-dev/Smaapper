//
//  ThemeProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/05/23.
//

import UIKit

protocol ThemeProtocol {
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
    
    var error: UIColor { get }
    var onError: UIColor { get }
    
}
