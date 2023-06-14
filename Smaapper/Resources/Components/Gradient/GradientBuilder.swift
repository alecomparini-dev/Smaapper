//
//  GradientBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 28/05/23.
//

import UIKit


class GradientBuilder {
    
    private weak var component: UIView?
    private var gradient: Gradient
    
    
//  MARK: - Initializers
    
    init(_ component: UIView) {
        self.component = component
        self.gradient = Gradient()
        self.initialization()
    }
    
    convenience init() {
        self.init(UIView())
    }
    
    private func initialization() {
        self.setGradientDirection(Gradient.Direction.leftToRight)
        self.setType(.axial)
    }
    
//  MARK: - Set Properties
    
    @discardableResult
    func setGradientColors(_ colors: [UIColor]) -> Self {
        self.gradient.colors = colors.map { $0.cgColor }
        return self
    }
    
    @discardableResult
    func setReferenceColor(_ referenceColor: UIColor, percentageGradient: CGFloat) -> Self {
        let colors = [referenceColor, referenceColor.adjustBrightness(percentageGradient)]
        self.gradient.colors = colors.map { $0.cgColor }
        return self
    }
    
    @discardableResult
    func setAxialGradient(_ direction: Gradient.Direction ) -> Self {
        self.setGradientDirection(direction)
        self.setType(.axial)
        self.gradient.isAxial = true
        return self
    }
    
    @discardableResult
    func setConicGradient(_ startPoint: CGPoint) -> Self {
        self.setStartPoint(startPoint.x, startPoint.y)
        self.setType(.conic)
        return self
    }
    
    @discardableResult
    func setRadialGradient(startPoint: CGPoint, _ endPoint: CGPoint?) -> Self {
        self.setStartPoint(startPoint.x, startPoint.y)
        self.gradient.endPoint = endPoint ?? CGPointZero
        self.setType(.radial)
        return self
    }
    
    @discardableResult
    func setOpacity(_ opacity: Float) -> Self {
        self.gradient.opacity = opacity
        return self
    }
    
    
    
//  MARK: - Apply Gradient
    @discardableResult
    func apply() -> Self {
        DispatchQueue.main.async {
            self.applyGradient()
        }
        return self
    }
    
        
//  MARK: - Component Private Functions
    
    private func setGradientDirection(_ direction: Gradient.Direction) {
        
        switch direction {
            case .leftToRight:
                setStartPoint(0.0, 0.5)
                setEndPoint(1.0, 0.5)
            
            case .rightToLeft:
                setStartPoint(1.0, 0.5)
                setEndPoint(0.0, 0.5)
            
            case .topToBottom:
                setStartPoint(0.5, 0.0)
                setEndPoint(0.5, 1.0)
            
            case .bottomToTop:
                setStartPoint(0.5, 1.0)
                setEndPoint(0.5, 0.0)
            
            case .leftBottomToRightTop:
                setStartPoint(0.0, 1.0)
                setEndPoint(1.0, 0.0)
            
            case .leftTopToRightBottom:
                setStartPoint(0.0, 0.0)
                setEndPoint(1.0, 1.0)
            
            case .rightBottomToLeftTop:
                setStartPoint(1.0, 1.0)
                setEndPoint(0.0, 0.0)
            
            case .rightTopToLeftBottom:
                setStartPoint(1.0, 0.0)
                setEndPoint(0.0, 1.0)
        }
        
    }

    private func configGradient() {
        guard let component else {return}
        gradient.cornerRadius = component.layer.cornerRadius
        gradient.maskedCorners = component.layer.maskedCorners
    }
    

    private func calculateIndexLayer() -> UInt32 {
        return UInt32(self.component?.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0)
    }
    
    
//  MARK: - Apply Gradient
    
    private func applyGradient() {
        guard let component else {return}
        self.configGradient()
        self.gradient.frame = component.bounds
        if !self.gradient.isAxial && self.gradient.endPoint == CGPointZero {
            let endY = component.frame.size.width / component.frame.size.height / 2
            self.gradient.endPoint = CGPoint(x: 0, y: endY)
        }
        self.setGradientOnComponent()
    }
    
    private func setGradientOnComponent() {
        let indexLayer = calculateIndexLayer()
        component?.layer.insertSublayer(gradient, at: indexLayer)
    }
    
    
    private func setType(_ type: CAGradientLayerType) {
        self.gradient.type = type
    }
    
    private func setStartPoint(_ x: Double, _ y: Double) {
        self.gradient.startPoint = CGPoint(x: x, y: y)
    }
    
    private func setEndPoint(_ x: Double, _ y: Double) {
        self.gradient.endPoint = CGPoint(x: x, y: y)
    }
    
    
}
