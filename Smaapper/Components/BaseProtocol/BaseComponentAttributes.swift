//
//  BaseComponentAttributes.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import UIKit

class BaseComponentAttributes: UIView {
    
    private var constraintsFlow: StartOfConstraintsFlow?
    private var border: Border?
    private var shadow: Shadow?
    private var neumorphism: Neumorphism?
    private var gradient: Gradient?
    private var tapGesture: TapGesture?
    
    @discardableResult
    func setBorder(_ border: (Border) -> Border) -> Self {
        self.border = border(Border(self))
        return self
    }
    
    @discardableResult
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> Self {
        self.shadow = shadow(Shadow(self))
        return self
    }
    
    @discardableResult
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        self.neumorphism = neumorphism(Neumorphism(self))
        return self
    }

    @discardableResult
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        self.gradient = gradient(Gradient(self))
        return self
    }
    
    @discardableResult
    func setTapGesture(_ tapGesture: (TapGesture) -> TapGesture) -> Self {
        self.tapGesture = tapGesture(TapGesture(self))
        return self
    }
    
//  MARK: - Constraint Area
    @discardableResult
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintsFlow = builderConstraint(StartOfConstraintsFlow(self))
        return self
    }
    
    func applyConstraint() {
        self.constraintsFlow?.applyConstraint()
    }
    
    
}
