//
//  BaseAttributeBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import Foundation

import UIKit

class BaseAttributeBuilder {
    
    var constraintsFlow: StartOfConstraintsFlow?
    var border: Border?
    var shadow: Shadow?
    var neumorphism: Neumorphism?
    var gradient: Gradient?
    var tapGesture: TapGesture?
    
    private var component: UIView
    
    init(_ component: UIView) {
        self.component = component
    }
    
    
//  MARK: - SET Properties
    @discardableResult
    func setBorder(_ border: (Border) -> Border) -> Self {
        self.border = border(Border(component))
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
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        self.gradient = gradient(Gradient(component))
        return self
    }

    @discardableResult
    func setTapGesture(_ tapGesture: (TapGesture) -> TapGesture) -> Self {
        self.tapGesture = tapGesture(TapGesture(component))
        return self
    }
    
    @discardableResult
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self {
        self.constraintsFlow = builderConstraint(StartOfConstraintsFlow(component))
        return self
    }
    
    func applyConstraint() {
        self.constraintsFlow?.applyConstraint()
    }

    
    
////  MARK: - MAKE Properties
//    @discardableResult
//    func _makeBorder(component: UIView, _ border: (Border) -> Border) -> Self {
//        self.border = border(Border(component))
//        return self
//    }
//    
//    @discardableResult
//    func _makeShadow(component: UIView, _ shadow: (_ build: Shadow) -> Shadow) -> Self {
//        self.shadow = shadow(Shadow(component))
//        return self
//    }
//
//    @discardableResult
//    func _makeNeumorphism(component: UIView, _ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
//        self.neumorphism = neumorphism(Neumorphism(component))
//        return self
//    }
//
//    @discardableResult
//    func _makeGradient(component: UIView, _ gradient: (_ build: Gradient) -> Gradient) -> Self {
//        self.gradient = gradient(Gradient(component))
//        return self
//    }
//
//    @discardableResult
//    func _makeTapGesture(component: UIView, _ tapGesture: (TapGesture) -> TapGesture) -> Self {
//        self.tapGesture = tapGesture(TapGesture(component))
//        return self
//    }

    
}
