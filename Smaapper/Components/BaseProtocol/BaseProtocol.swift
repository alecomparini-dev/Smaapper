//
//  BaseProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/05/23.
//

import UIKit

protocol BaseComponentProtocol {
    var constraintsFlow: StartOfConstraintsFlow? {get set}
    func setBorder(_ border: (_ build: BorderBuilder) -> BorderBuilder) -> Self
    func setShadow(_ shadow: (_ build: Shadow) -> Shadow )  -> Self
    func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self
    func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self
    func setTapGesture(_ gesture: (_ build: TapGesture) -> TapGesture) -> Self
    func setConstraints(_ builderConstraint: (_ build: StartOfConstraintsFlow) -> StartOfConstraintsFlow) -> Self
    func applyConstraint()
    
}

