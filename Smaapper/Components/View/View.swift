//
//  View.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/04/23.
//

import UIKit


class View: UIView, BaseComponentProtocol {
    internal var constraintsFlow: StartOfConstraintsFlow?
    internal var shadow: Shadow?
    internal var neumorphism: Neumorphism?
    internal var gradient: Gradient?
    
    init() {
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Resize.resize(self)
//        print("remover layoutsubviews" , self)
    }

    
    @discardableResult
    func setBorder(_ border: (_ build: Border) -> Border) -> Self {
        let _ = border(Border(self))
        return self
    }
    
    @discardableResult
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> Self {
        self.shadow = shadow(Shadow(self))
        return self
    }
    func applyShadow() {
        self.shadow?.apply()
    }
    
    @discardableResult
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        self.neumorphism = neumorphism(Neumorphism(self))
        return self
    }
    func applyNeumorphism() {
        self.neumorphism?.apply()
    }
    
    @discardableResult
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        self.gradient = gradient(Gradient(self))
        return self
    }
    func applyGradient() {
        self.gradient?.apply()
    }
    
    @discardableResult
    func setTapGesture(_ gesture: (_ build: TapGesture) -> TapGesture) -> Self {
        let _ = gesture(TapGesture(self))
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



