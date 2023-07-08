//
//  BaseAttributeBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import Foundation

import UIKit

class BaseBuilder: NSObject {
    
    private(set) var constraintsFlow: StartOfConstraintsFlow?
    private(set) var border: BorderBuilder?
    private(set) var shadow: ShadowBuilder?
    private(set) var neumorphism: NeumorphismBuilder?
    private(set) var gradient: GradientBuilder?
    private(set) var blur: BlurBuilder?
    
    private weak var _component: UIView?
    
    init(_ component: UIView) {
        self._component = component
    }

    
//  MARK: - GET Properties
    
    var component: UIView {
        get { self._component ?? UIView() }
        set { self._component = newValue }
    }
    
        
//  MARK: - SET Properties
    @discardableResult
    func setBorder(_ build: (_ build: BorderBuilder) -> BorderBuilder) -> Self {
        self.border = build(BorderBuilder(component))
        return self
    }

    @discardableResult
    func setShadow(_ build: (_ build: ShadowBuilder) -> ShadowBuilder) -> Self {
        self.shadow = build(ShadowBuilder(component))
        return self
    }

    @discardableResult
    func setNeumorphism(_ build: (_ build: NeumorphismBuilder) -> NeumorphismBuilder) -> Self {
        self.neumorphism = build(NeumorphismBuilder(component))
        return self
    }

    @discardableResult
    func setGradient(_ build: (_ build: GradientBuilder) -> GradientBuilder) -> Self {
        self.gradient = build(GradientBuilder(component))
        return self
    }

    @discardableResult
    func setBlur(_ build: (_ build: BlurBuilder) -> BlurBuilder) -> Self {
        self.blur = build(BlurBuilder(component))
        return self
    }

    @discardableResult
    public func setBackgroundColor(_ color: UIColor) -> Self {
        component.backgroundColor = color
        return self
    }
        
    @discardableResult
    func setBackgroundColorLayer(_ color: UIColor) -> Self {
        let layer = CAShapeLayer()
        layer.fillColor = color.cgColor
        layer.backgroundColor = color.cgColor
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            let position = UInt32(self.countShadows())
            self.component.layer.insertSublayer(layer, at: position )
            layer.path = self.component.replicateFormat().cgPath
        }
        return self
    }
    
    @discardableResult
    func setIsUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        self.component.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    public func setOpacity(_ opacity: Float) -> Self {
        component.layer.opacity = opacity
        return self
    }
    
    @discardableResult
    public func setAlpha(_ alpha: CGFloat) -> Self {
        component.alpha = alpha
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

