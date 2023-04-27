//
//  ShadowBuilder.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 10/04/23.
//

import UIKit

class Shadow {
    
    private var component: UIView
    private var shadowLayer: CAShapeLayer!
    
//  MARK: - Initializers
    
    init(_ component: UIView) {
        self.component = component
        self.setInitializers()
        let _ = self.setDefault()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - Properties
    
    func setColor(_ color: UIColor) -> Self {
        component.layer.shadowColor = color.cgColor
        return self
    }
    
    func setOffset(width: Int, height: Int) -> Self {
        component.layer.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    func setOffset(_ offSet: CGSize) -> Self {
        component.layer.shadowOffset = offSet
        return self
    }
    
    func setOpacity(_ opacity: Float) -> Self {
        component.layer.shadowOpacity = opacity
        return self
    }
    
    func setRadius(_ radius: CGFloat) -> Self {
        component.layer.shadowRadius = radius
        return self
    }
    
    
//  MARK: - Component private functions
    
    func setDefault() -> Self {
        return self.setColor(ShadowDefault.color)
            .setOffset(ShadowDefault.offset)
            .setOpacity(ShadowDefault.opacity)
            .setRadius(ShadowDefault.radius)
    }
    
    private func setInitializers() {
        self.component.layer.masksToBounds = false
        self.component.layer.shouldRasterize = true
        self.component.layer.rasterizationScale = UIScreen.main.scale
    }
    
    

    
    
}
