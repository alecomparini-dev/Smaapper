//
//  View.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/04/23.
//

import UIKit


class View: UIView, BaseComponentProtocol {
    internal var constraintsFlow: StartOfConstraintsFlow?
    
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
//        print("remover aqui layoutsubviews" , self)
    }

    
    @discardableResult
    func setBorder(_ border: (_ build: Border) -> Border) -> Self {
        let _ = border(Border(self))
        return self
    }
    
    @discardableResult
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> Self {
        _ = shadow(Shadow(self))
        return self
    }
    
    @discardableResult
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        _ = neumorphism(Neumorphism(self))
        return self
    }
    
    @discardableResult
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        _ = gradient(Gradient(self))
        return self
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





class CustomLabel: UILabel {
    
    func setText(_ string: String) -> Self {
        self.text = string
        return self
    }
    
}

class CustomTextField: UITextField {
    
    func setText(_ string: String) -> Self {
        self.text = string
        return self
    }

}

class AttrBase {
    
    func setBackColor(_ color: UIColor) -> Self {
        self.color = color
        return self
    }
}
