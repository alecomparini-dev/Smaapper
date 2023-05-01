//
//  Button3D.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 29/04/23.
//

import UIKit


class Button3D: ButtonImage {
    
    
//  MARK: - Initializers
    
    override init() {
        super.init()
        self.buildShadow3D()
    }
    
    override init(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil) {
        super.init(image, state, nil)
        self.buildShadow3D()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - Build Shadow
    private func buildShadow3D() {
        buildShadowTop()
        buildShadowBottom()
    }
    
    private func buildShadowTop() {
        _ = self.setShadow { build in
            build.setColor(Button3DDefault.colorShadowTop.withAlphaComponent(Button3DDefault.opacityShadowTop))
                .setOffset(Button3DDefault.offsetShadowTop)
                .setOpacity(1)
                .setRadius(Button3DDefault.radius)
                .apply()
        }
    }
    
    private func buildShadowBottom() {
        _ = self.setShadow { build in
            build.setColor(Button3DDefault.colorShadowBottom.withAlphaComponent(Button3DDefault.opacityShadowBottom))
                .setOffset(Button3DDefault.offsetShadowBottom)
                .setOpacity(1)
                .setRadius(Button3DDefault.radius)
                .apply()
        }
    }
    
}
