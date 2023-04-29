//
//  ShadowBuilder.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 10/04/23.
//

import UIKit

class Shadow {
    
    private var component: UIView
    private let shadow: CALayer
    
//  MARK: - Initializers
    
    init(_ component: UIView) {
        self.component = component
        self.shadow = CALayer()
        self.setInitializers()
        let _ = self.setDefault()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - Properties
    
    func setColor(_ color: UIColor) -> Self {
        shadow.shadowColor = color.cgColor
        return self
    }
    
    func setOffset(width: Int, height: Int) -> Self {
        shadow.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    func setOffset(_ offSet: CGSize) -> Self {
        shadow.shadowOffset = offSet
        return self
    }
    
    func setOpacity(_ opacity: Float) -> Self {
        shadow.shadowOpacity = opacity
        return self
    }
    
    func setRadius(_ radius: CGFloat) -> Self {
        shadow.shadowRadius = radius
        return self
    }
    
    
//  MARK: - Component private functions
    
    func setDefault() -> Self {
        return self.setColor(ShadowDefault.color)
            .setOffset(ShadowDefault.offset)
            .setOpacity(ShadowDefault.opacity)
            .setRadius(ShadowDefault.radius)
    }
    
    func apply() -> Self {
        DispatchQueue.main.async {
            self.component.layoutIfNeeded()
            self.shadow.frame = self.component.bounds
            self.shadow.backgroundColor = UIColor.clear.cgColor
            self.shadow.shadowPath = UIBezierPath(roundedRect: self.component.bounds,
                                                  cornerRadius: self.component.layer.cornerRadius).cgPath
            self.component.layer.insertSublayer(self.shadow, at: 0)
        }
        return self
    }
    
    private func setInitializers() {
        self.component.layer.masksToBounds = false
        self.component.layer.shouldRasterize = true
        self.component.layer.rasterizationScale = UIScreen.main.scale
    }
    
}
