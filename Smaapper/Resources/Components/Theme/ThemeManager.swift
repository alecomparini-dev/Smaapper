//
//  ThemeManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/05/23.
//

import UIKit

protocol ThemeStrategy {
    var backgroundColor: UIColor { get }
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

class ThemeDarkDefault: ThemeStrategy {
    var backgroundColor: UIColor = UIColor.HEX("#292D2E")
}


class ThemeLightDefault: ThemeStrategy {
    var backgroundColor: UIColor = .white
}
