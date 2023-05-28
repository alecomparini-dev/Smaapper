//
//  BaseAttributeBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import Foundation

import UIKit

class BaseBuilder {
    
    private(set) var constraintsFlow: StartOfConstraintsFlow?
    private(set) var border: BorderBuilder?
    private(set) var shadow: Shadow?
    private(set) var neumorphism: Neumorphism?
    private(set) var gradient: GradientBuilder?
    private(set) var tapGesture: TapGestureBuilder?
    private(set) var blur: Blur?
    
    private(set) var component: UIView
    
    init(_ component: UIView) {
        self.component = component
    }
    
        
//  MARK: - SET Properties
    @discardableResult
    func setBorder(_ border: (_ build: BorderBuilder) -> BorderBuilder) -> Self {
        self.border = border(BorderBuilder(component))
        return self
    }

    @discardableResult
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> Self {
        self.shadow = shadow(Shadow(component))
        return self
    }

    @discardableResult
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        self.neumorphism = neumorphism(Neumorphism(component))
        return self
    }

    @discardableResult
    func setGradient(_ gradient: (_ build: GradientBuilder) -> GradientBuilder) -> Self {
        self.gradient = gradient(GradientBuilder(component))
        return self
    }

    @discardableResult
    func setTapGesture(_ tapGesture: (_ build: TapGestureBuilder) -> TapGestureBuilder) -> Self {
        self.tapGesture = tapGesture(TapGestureBuilder(component))
        return self
    }
    
    @discardableResult
    func setBlur(_ blur: (_ build: Blur) -> Blur) -> Self {
        self.blur = blur(Blur(component))
        return self
    }

    @discardableResult
    public func setBackgroundColor(_ color: UIColor) -> Self {
        component.backgroundColor = color
        return self
    }
        
    @discardableResult
    func setBackgroundColorLayer(_ color: UIColor) -> Self {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            let layer = CAShapeLayer()
            layer.path = self.component.replicateFormat().cgPath
            layer.fillColor = color.cgColor
            layer.backgroundColor = color.cgColor
            let position = UInt32(self.countShadows())
            self.component.layer.insertSublayer(layer, at: position )
        }
        return self
    }
    
    @discardableResult
    func setUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        self.component.isUserInteractionEnabled = interactionEnabled
        return self
    }
   
    
//  MARK: - CONSTRAINTS AREA
    @discardableResult
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintsFlow = builderConstraint(StartOfConstraintsFlow(component))
        return self
    }
    
    @discardableResult
    func applyConstraint() -> Self {
        self.constraintsFlow?.apply()
        return self
    }

    func add(insideTo element: UIView) {
        if element.isKind(of: UIStackView.self) {
            let element = element as! UIStackView
            element.addArrangedSubview(component)
            return
        }
        element.addSubview(component)
    }


//  MARK: - Private Area
    private func countShadows() -> Int {
        return component.layer.sublayers?.filter({ $0.shadowOpacity > 0 }).count ?? 0
    }

    
}
