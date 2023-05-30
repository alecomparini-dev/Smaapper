//
//  ThemeManager.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/05/23.
//

import UIKit

class Theme {
    static let shared = Theme()
    
    var currentTheme: ThemeProtocol
    
    private init() {
        self.currentTheme = ThemeDarkDefault()
    }
    
    static func setTheme(_ theme: ThemeProtocol) {
        Theme.shared.currentTheme = theme
    }
    
}
