//
//  CategoriesView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 13/05/23.
//

import UIKit


class CategoriesView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBackgroundColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addBackgroundColor() {
        _ = self.setGradient { build in
            build
                .setColor([UIColor.HEX("#17191a").getBrightness(1.7),  UIColor.HEX("#17191a").getBrightness(0.7)])
                .setAxialGradient(.leftTopToRightBottom)
                .setAxialGradient(.topToBottom)
                .apply()
        }
    }
    
}
