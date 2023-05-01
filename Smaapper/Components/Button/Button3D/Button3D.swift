//
//  Button3D.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 29/04/23.
//

import UIKit


class Button3D: ButtonImage {

    private let shadowTop: CALayer
    private let shadowBottom: CALayer
    private let intensityShadowTop: CGFloat = 1
    private let intensityShadowBottom: CGFloat = 1
    
    
    
//  MARK: - Initializers
    
    override init() {
        self.shadowTop = CALayer()
        self.shadowBottom = CALayer()
        super.init()
        self.button3DInitialization()
    }
    
    override init(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil) {
        self.shadowTop = CALayer()
        self.shadowBottom = CALayer()
        super.init(image, state, nil)
        self.button3DInitialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func button3DInitialization() {
        shadowInitializers()
        buildShadow3D()
    }
    
    
    
    
//  MARK: - Build Shadow
    private func buildShadow3D() {
        buildShadowTop()
        buildShadowBottom()
        buildBorder()
    }
    
    private func buildShadowTop() {
        _ = self.setShadow { build in
            build.setColor(.white.withAlphaComponent(0.13))
                .setOffset(width: -5, height: -2)
                .setOpacity(1)
                .setRadius(8)
                .apply()
        }
    }
    
    private func buildShadowBottom() {
        _ = self.setShadow { build in
            build.setColor(.black.withAlphaComponent(0.8))
                .setOffset(width: 8, height: 8)
                .setOpacity(1)
                .setRadius(8)
                .apply()
        }
    }
    
    private func buildBorder() {
        _ = setBorder({ build in
            build.setWidth(1)
                .setColor(.white.withAlphaComponent(0.2))
        })
    }
    
    private func shadowInitializers() {
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
