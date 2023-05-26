//
//  ShadowBuilder.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 10/04/23.
//

import UIKit

class Shadow {
    
    private var component: UIView
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
    func setBlur(_ blur: CGFloat) -> Self {
        shadow.shadowRadius = blur
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
    
    
//  MARK: - Component private functions
    
    @discardableResult
    func apply() -> Self {
        DispatchQueue.main.async {
            self.shadow.frame = self.component.bounds
            self.shadow.shadowPath = self.calculateShadowPath()
            self.insertSubLayer()
        }
        return self
    }
    
    private func getCornerRadius() -> CGFloat {
        if let cornerRadius {
            return cornerRadius
        }
        return self.component.layer.cornerRadius
    }
    
    private func calculateShadowPath() -> CGPath {
        let cornerRadius = self.getCornerRadius()
        let shadowHeight = self.getShadowHeight()
        let shadowWidth  = self.getShadowWidth()
        
        return UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0),
                                                size: CGSize(width: shadowWidth,
                                                             height: shadowHeight)),
                            byRoundingCorners: self.component.layer.maskedCorners.toRectCorner ,
                            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
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
        shadow.shouldRasterize = true
        shadow.rasterizationScale = UIScreen.main.scale
        
    }
    
    private func setDefault(){
        setColor(.black)
            .setOpacity(0.6)
            .setBlur(5)
    }
    
}


extension UIView {
    func removeShadowByID(_ id: String) {
        if let layerToRemove = self.layer.sublayers?.first(where: { $0.name == id }) {
            layerToRemove.removeFromSuperlayer()
        }
    }
    
}
