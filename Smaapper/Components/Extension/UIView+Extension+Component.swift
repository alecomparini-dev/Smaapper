//
//  UIView+Extension+Component.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 11/04/23.
//

import UIKit

extension UIView {
    
    func add(insideTo element: UIView) {
        if element.isKind(of: UIStackView.self) {
            let element = element as! UIStackView
            element.addArrangedSubview(self)
        }
        element.addSubview(self)
    }
    
    public func setBackgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    func setUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    
//  MARK: - SHADOW
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow )  -> Self {
        let _ = shadow(Shadow(self))
        return self
    }
    
    
//  MARK: - BORDER
    func setBorder(_ border: (_ build: Border) -> Border) -> Self {
        let _ = border(Border(self))
        return self
    }

    
//  MARK: - GRADIENT
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        let _ = gradient(Gradient(self))
        return self
    }
    
//  MARK: - Apply Constraints
    
    func applyConstraints(_ buildConstraintFlow: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) {
        let constraints = buildConstraintFlow(StartOfConstraintsFlow(self))
        constraints.applyConstraint()
    }
    
    
//  MARK: - hideKeyboardWhenViewTapped
    
    func hideKeyboardWhenViewTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    
}
