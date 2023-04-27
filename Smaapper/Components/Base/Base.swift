//
//  Base.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 28/03/23.
//

import UIKit

class Base {

    private var baseVM = BaseViewModel()
    private var componentUI: UIView
    
    init(_ componentUI: UIView) {
        self.componentUI = componentUI
    }
    
//    public func setConstraints(_ constraints: Constraints) -> Self {
//        baseVM.constraints = constraints
//        return self
//    }
//    
    public func setUserInteractionEnabled(_ value: Bool) -> Self {
        baseVM.userInteractionEnabled = value
        return self
    }
    
    public func setBackgroundColor(_ value: UIColor) -> Self {
        baseVM.backgroundColor = value
        return self
    }
    
    public func setGradient(_ value: Gradient) -> Self {
        baseVM.gradient = value
        return self
    }

    
//  MARK: - ADD ELEMENT
    public func add(insideTo element: UIView) {
        if element.isKind(of: UIStackView.self) {
            let element = element as! UIStackView
            element.addArrangedSubview(componentUI)
        }
        element.addSubview(componentUI)
//        applyConstraints()
    }
    
    
//  MARK: - APPLY CONSTRAINTS
//    private func applyConstraints() {
//        guard let constraint = baseVM.constraints else { return }
//        constraint.apply(componentUI)
//    }
    
    public func buildBase() {
        buildUserInteractionEnabled()
        buildBackgroundColor()
        buildGradient()
    }
    
    private func buildUserInteractionEnabled() {
        guard let userInteractionEnabled = baseVM.userInteractionEnabled else {return}
        componentUI.isUserInteractionEnabled = userInteractionEnabled
    }
    
    private func buildBackgroundColor() {
        guard let backgroundColor = baseVM.backgroundColor else {return}
        componentUI.backgroundColor = backgroundColor      
    }
    

    private func buildGradient() {
        guard let gradient = baseVM.gradient else { return }
        gradient.apply(componentUI)
    }
    
}
