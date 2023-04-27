//
//  ConstraintModel.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

struct ConstraintsModel {
    var typeElement: ConstraintsTypeElement = .element
    var mainElement: UIView = UIView()
    var mainAttribute: [ConstraintsAttribute] = []
    var relation: ConstraintsRelations = .equalTo
    var toItem: UIView? = nil
    var toAttribute: ConstraintsAttribute? = nil 
    var constant: CGFloat = 0
    var multiplier: CGFloat = 1
}
