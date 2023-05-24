//
//  BaseAttributeBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import Foundation

import UIKit

class BaseAttributeBuilder {
    
    private var _constraintsFlow: StartOfConstraintsFlow?
    private var _border: Border?
    private var _shadow: Shadow?
    private var _neumorphism: Neumorphism?
    private var _gradient: Gradient?
    private var _tapGesture: TapGesture?
    
    private var component: UIView
    
    init(_ component: UIView) {
        self.component = component
    }
    
    
//  MARK: - GET Properties
    var constraintsFlow: StartOfConstraintsFlow? { self._constraintsFlow}
    var border: Border? { self._border}
    var shadow: Shadow? { self._shadow}
    var neumorphism: Neumorphism? { self._neumorphism}
    var gradient: Gradient? { self._gradient}
    var tapGesture: TapGesture? { self._tapGesture}
    
    
//  MARK: - SET Properties
    @discardableResult
    func setBorder(_ border: (Border) -> Border) -> Self {
        self._border = border(Border(component))
        return self
    }
    
    @discardableResult
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> Self {
        self._shadow = shadow(Shadow(component))
        return self
    }

    @discardableResult
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        self._neumorphism = neumorphism(Neumorphism(component))
        return self
    }

    @discardableResult
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        self._gradient = gradient(Gradient(component))
        return self
    }

    @discardableResult
    func setTapGesture(_ tapGesture: (TapGesture) -> TapGesture) -> Self {
        self._tapGesture = tapGesture(TapGesture(component))
        return self
    }
    
    @discardableResult
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self._constraintsFlow = builderConstraint(StartOfConstraintsFlow(component))
        return self
    }
    
    func applyConstraint() {
        self.constraintsFlow?.applyConstraint()
    }

    func add(insideTo element: UIView) {
        if element.isKind(of: UIStackView.self) {
            let element = element as! UIStackView
            element.addArrangedSubview(component)
            return
        }
        element.addSubview(component)
    }

    
}
