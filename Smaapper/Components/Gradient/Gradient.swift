//
//  Gradient.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/04/23.
//

import UIKit

class Gradient {
    
    enum Direction {
        case leftToRight
        case rightToLeft
        case topToBottom
        case bottomToTop
        case leftBottomToRightTop
        case leftTopToRightBottom
        case rightBottomToLeftTop
        case rightTopToLeftBottom
    }
    
    private var isAxial = false
    private var gradient = CAGradientLayer()
    private var component: UIView
    
    
//  MARK: - Initializers
    
    init(_ component: UIView) {
        self.component = component
        self.initialization()
    }
    
    private func initialization() {
        self.setGradientDirection(.leftToRight)
        self.setType(.axial)
    }
    
//  MARK: - Set Properties
    
    func setColor(_ colors: [UIColor]) -> Self {
        self.gradient.colors = colors.map { $0.cgColor }
        return self
    }
    
    func setAxialGradient(_ direction: Gradient.Direction ) -> Self {
        self.setGradientDirection(direction)
        self.setType(.axial)
        self.isAxial = true
        return self
    }
    
    func setConicGradient(_ startPoint: CGPoint) -> Self {
        self.setStartPoint(startPoint.x, startPoint.y)
        self.setType(.conic)
        return self
    }
    
    func setRadialGradient(_ startPoint: CGPoint) -> Self {
        self.setStartPoint(startPoint.x, startPoint.y)
        self.setType(.radial)
        return self
    }
    
    
    
//  MARK: - Apply Gradient
    func apply() -> Self {
        DispatchQueue.main.async() {
            self.applyGradient()
        }
        return self
    }
        
//  MARK: - Component Private Functions
    
    private func setGradientDirection(_ direction: Direction) {
        
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
        gradient.cornerRadius = component.layer.cornerRadius
        gradient.maskedCorners = component.layer.maskedCorners
        gradient.shouldRasterize = true
        gradient.rasterizationScale = UIScreen.main.scale
    }
    

    private func calculateIndexLayer() -> UInt32 {
        return UInt32(self.component.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0)
    }
    
    
//  MARK: - Apply Gradient
    
    private func applyGradient() {
        self.configGradient()
        gradient.frame = component.bounds
        if !isAxial {
            let endY = 0 + component.frame.size.width / component.frame.size.height / 2
            gradient.endPoint = CGPoint(x: 0, y: endY)
        }
        self.setGradientOnComponent()
    }
    
    private func setGradientOnComponent() {
        let indexLayer = calculateIndexLayer()
        component.layer.insertSublayer(gradient, at: indexLayer)
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

