//
//  UtilsFloatView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

class UtilsFloatView {

    static func configNeumorphisFloatView(_ view: ViewBuilder) {
        view.setNeumorphism { build in
            build
                .setReferenceColor(Theme.shared.currentTheme.surfaceContainerLow)
                .setShape(.concave)
                .setLightPosition(.leftTop)
                .setBlur(to: .light, percent: 5)
                .setBlur(to: .dark, percent: 20)
                .setDistance(to: .dark, percent: 20)
                .apply()
        }
    }

    static func setShadowActiveFloatView(_ view: ViewBuilder) {
        view.setShadow { build in
            build
                .setColor(Theme.shared.currentTheme.primary)
                .setOffset(width: 0, height: 0)
                .setOpacity(0.8)
                .setRadius(2)
                .setBringToFront()
                .setID("activeFloatView")
                .apply()
        }
    }
    
    static func removeShadowActiveFloatView(_ view: ViewBuilder) {
        view.view.removeShadowByID("activeFloatView")
    }
    
    
    
}

