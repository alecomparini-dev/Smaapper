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
    private var shadowAt: UInt32 = 0
    private var isBringToFront: Bool = false
    
//  MARK: - Initializers
    
    init(_ component: UIView) {
        self.component = component
        self.shadow = CALayer()
        self.shadowInitializers()
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
    
    func setBringToFront() -> Self {
        self.isBringToFront = true
        return self
    }
    
    func setID(_ id: String) -> Self {
        shadow.name = id
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
            self.shadow.shadowPath = UIBezierPath(roundedRect: self.component.bounds,
                                                  cornerRadius: self.component.layer.cornerRadius).cgPath
            self.insertSubLayer()
        }
        return self
    }
//
//    func applyToComponent() -> Self {
////        self.shadow.frame = self.component.bounds
////        self.component.layoutIfNeeded()
//
////        self.component.frame = self.component.bounds
//        self.component.layer.shadowPath = UIBezierPath(roundedRect: self.component.bounds,
//                                              cornerRadius: self.component.layer.cornerRadius).cgPath
//
//        component.layer.shadowColor = shadow.shadowColor
//        component.layer.shadowRadius = shadow.shadowRadius
//        component.layer.shadowOffset = shadow.shadowOffset
//        component.layer.shadowOpacity = shadow.shadowOpacity
//        return self
//    }
    
    private func insertSubLayer() {
        if isBringToFront {
            self.shadowAt = UInt32(self.component.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0)
        }
        self.component.layer.insertSublayer(self.shadow, at: self.shadowAt)
    }
    
    private func shadowInitializers() {
        let _ = self.setDefault()
        self.component.layer.masksToBounds = false
        self.component.layer.shouldRasterize = true
        self.component.layer.rasterizationScale = UIScreen.main.scale
        self.shadow.shouldRasterize = true
        self.shadow.rasterizationScale = UIScreen.main.scale
    }
    
}


extension UIView {
    func removeShadowByID(_ id: String) {
        if let layerToRemove = self.layer.sublayers?.first(where: { $0.name == id }) {
            layerToRemove.removeFromSuperlayer()
        }
    }
    
}
