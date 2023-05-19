//
//  BaseProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/05/23.
//

import UIKit

protocol BaseComponentProtocol {
    var constraintsFlow: StartOfConstraintsFlow? {get set}
    var shadow: Shadow? {get set}
    var neumorphism: Neumorphism? {get set}
    var gradient: Gradient? {get set}
    func setBorder(_ border: (_ build: Border) -> Border) -> Self
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow )  -> Self
    func applyShadow()
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self
    func applyNeumorphism()
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self
    func applyGradient()
    func setTapGesture(_ gesture: (_ build: TapGesture) -> TapGesture) -> Self
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self
    func applyConstraint()
    
}

