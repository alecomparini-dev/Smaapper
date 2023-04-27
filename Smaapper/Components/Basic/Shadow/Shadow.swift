//
//  Shadow.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 25/03/23.
//

import UIKit

class Shadow {
    
    enum ViewStyle {
        case outerView
        case innerView
    }

    private var shadowVM: ShadowViewModel = ShadowViewModel()

    
    func setRadius(_ value: Int) -> Self {
        shadowVM.radius = value
        return self
    }
    
    func setViewStyle(_ value: Shadow.ViewStyle) -> Self {
        shadowVM.viewStyle = value
        shadowVM.thickness = 50
        return self
    }
    
    func setOpacity(_ value: Float) -> Self {
        shadowVM.opacity = value
        return self
    }
    
    func setColor(_ value: UIColor) -> Self {
        shadowVM.color = value
        return self
    }
    
    func setThickness(_ value: Int) -> Self {
        shadowVM.thickness = value
        return self
    }
    
    func setOffset(width: Int, height: Int) -> Self {
        shadowVM.offset(width, height)
        return self
    }
    
    func build() -> Self {
        return self
    }
    
    func apply(_ elem: UIView) {
        elem.layer.masksToBounds = false
        elem.layer.shouldRasterize = true
        elem.layer.rasterizationScale = UIScreen.main.scale
        elem.layer.shadowRadius = shadowVM.radius.toCGFloat
        elem.layer.shadowOpacity = shadowVM.opacity
        elem.layer.shadowOffset = shadowVM.offset
        elem.layer.shadowColor = shadowVM.color.cgColor
        buildViewStyle()
    }
    
    private func buildViewStyle() {
    }

}
