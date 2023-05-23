//
//  BaseComponentAttributes.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import UIKit

class BaseComponentAttributes<T: UIView> {
    
    var constraintsFlow: StartOfConstraintsFlow?
    var border: Border?
    var shadow: Shadow?
    var neumorphism: Neumorphism?
    var gradient: Gradient?
    var tapGesture: TapGesture?
    
    private let view: T?
  
    init() {
        self.view = UIView(frame: .zero) as? T
    }
    
    init(_ view: T) {
        self.view = view
    }
    
    @discardableResult
    func setBorder(_ border: (Border) -> Border) -> T {
        guard let view else { return view ?? UIView() as! T}
        self.border = border(Border(view))
        return view
    }
    
    @discardableResult
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> T {
        guard let view else { return view ?? UIView() as! T}
        self.shadow = shadow(Shadow(view))
        return view
    }

    @discardableResult
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> T {
        guard let view else { return view ?? UIView() as! T}
        self.neumorphism = neumorphism(Neumorphism(view))
        return view
    }

    @discardableResult
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> T {
        guard let view else { return view ?? UIView() as! T}
        self.gradient = gradient(Gradient(view))
        return view
    }

    @discardableResult
    func setTapGesture(_ tapGesture: (TapGesture) -> TapGesture) -> T {
        guard let view else { return view ?? UIView() as! T}
        self.tapGesture = tapGesture(TapGesture(view))
        return view
    }
    
//  MARK: - Constraint Area
    @discardableResult
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> T {
        guard let view else { return view ?? UIView() as! T}
        self.constraintsFlow = builderConstraint(StartOfConstraintsFlow(view))
        return view
    }
    
    func applyConstraint() {
        self.constraintsFlow?.applyConstraint()
    }
    
    
}
