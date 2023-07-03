//
//  ShadowBuilder.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 10/04/23.
//

import UIKit

class ShadowBuilder {
    
    private(set) var component: UIView
    private let shadow: CAShapeLayer
    private var shadowAt: UInt32 = 0
    private var isBringToFront: Bool = false
    private var cornerRadius: CGFloat?
    private var shadowHeight: CGFloat?
    private var shadowWidth: CGFloat?
    
//  MARK: - Initializers
    
    init(_ component: UIView) {
        self.component = component
        self.shadow = CAShapeLayer()
        self.shadowInitializers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - Properties
    
    @discardableResult
    func setColor(_ color: UIColor) -> Self {
        shadow.shadowColor = color.cgColor
        return self
    }
    
    @discardableResult
    func setOffset(width: Int, height: Int) -> Self {
        shadow.shadowOffset = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func setOffset(_ offSet: CGSize) -> Self {
        shadow.shadowOffset = offSet
        return self
    }
    
    @discardableResult
    func setOpacity(_ opacity: Float) -> Self {
        shadow.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    func setRadius(_ radius: CGFloat) -> Self {
        shadow.shadowRadius = radius
        return self
    }
    
    @discardableResult
    func setCornerRadius(_ cornerRadius: CGFloat) -> Self {
        shadow.cornerRadius = cornerRadius
        return self
    }
    
    @discardableResult
    func setBringToFront() -> Self {
        self.isBringToFront = true
        return self
    }
    
    @discardableResult
    func setShadowHeight(_ height: CGFloat) -> Self {
        self.shadowHeight = height
        return self
    }
    
    @discardableResult
    func setShadowWidth(_ width: CGFloat) -> Self {
        self.shadowWidth = width
        return self
    }
    
    @discardableResult
    func setID(_ id: String) -> Self {
        shadow.name = id
        return self
    }
    
    
//  MARK: - GET Properties
    func getShadowById(_ id: String) -> CALayer? {
        if let layer = self.component.layer.sublayers?.first(where: { $0.name == id }) {
            return layer
        }
        return nil
    }
    
    
//  MARK: - APPLY Shadow
    @discardableResult
    func apply() -> Self {
        self.insertSubLayer()
        DispatchQueue.main.async {
            self.shadow.frame = self.component.bounds
            self.shadow.shadowPath = self.calculateShadowPath()
        }
        return self
    }
    
    
//  MARK: - PRIVATE Area
    
    private func getCornerRadius() -> CGFloat {
        if let cornerRadius {
            return cornerRadius
        }
        return self.component.layer.cornerRadius
    }
    
    private func calculateShadowPath() -> CGPath {
        return component.replicateFormat(width: self.getShadowWidth(),
                                         height: self.getShadowHeight(),
                                         cornerRadius: self.getCornerRadius()
                                        ).cgPath
    }
    
    private func getShadowHeight() -> CGFloat {
        if let shadowHeight {
            return shadowHeight
        }
        return self.component.frame.height
    }
    
    private func getShadowWidth() -> CGFloat {
        if let shadowWidth {
            return shadowWidth
        }
        return self.component.frame.width
    }
    
    private func insertSubLayer() {
        if isBringToFront {
            self.shadowAt = UInt32(self.component.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0)
        }
        self.component.layer.insertSublayer(self.shadow, at: self.shadowAt)
    }
    
    private func shadowInitializers() {
        setDefault()
        component.layer.masksToBounds = false
        shadow.shouldRasterize = true
        shadow.rasterizationScale = UIScreen.main.scale
    }
    
    private func setDefault(){
        setColor(.black)
            .setOpacity(0.6)
            .setRadius(5)
    }
    
}


//  MARK: - EXTENSION UIView
extension UIView {
    func removeShadowByID(_ id: String) {
        if let layerToRemove = self.layer.sublayers?.first(where: { $0.name == id }) {
            layerToRemove.removeFromSuperlayer()
        }
    }
    
    func hasShadow() -> Bool {
        if (self.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0) > 0 {
            return true
        }
        return false
    }
    
}
