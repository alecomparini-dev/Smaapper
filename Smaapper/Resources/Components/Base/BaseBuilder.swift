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
    private(set) var blur: Blur?
    
    private weak var _component: UIView?
    
    init(_ component: UIView) {
        self._component = component
    }

//  MARK: - GET Properties
    
    var component: UIView {
        get { self._component  ?? UIView()}
        set { self._component = newValue}
    }
    
        
//  MARK: - SET Properties
    @discardableResult
    func setBorder(_ build: (_ build: BorderBuilder) -> BorderBuilder) -> Self {
        self.border = build(BorderBuilder(component))
        return self
    }

    @discardableResult
    func setShadow(_ build: (_ build: Shadow) -> Shadow) -> Self {
        self.shadow = build(Shadow(component))
        return self
    }

    @discardableResult
    func setNeumorphism(_ build: (_ build: Neumorphism) -> Neumorphism) -> Self {
        self.neumorphism = build(Neumorphism(component))
        return self
    }

    @discardableResult
    func setGradient(_ build: (_ build: GradientBuilder) -> GradientBuilder) -> Self {
        self.gradient = build(GradientBuilder(component))
        return self
    }

    @discardableResult
    func setBlur(_ build: (_ build: Blur) -> Blur) -> Self {
        self.blur = build(Blur(component))
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
    
    @discardableResult
    public func setOpacity(_ opacity: Float) -> Self {
        component.layer.opacity = opacity
        return self
    }
   
    @discardableResult
    public func setHidden(_ hide: Bool) -> Self {
        component.isHidden = hide
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

