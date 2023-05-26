//
//  ApplyConstraints.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 20/04/23.
//

import UIKit

class ApplyConstraints {
    
    private var constraints: [ConstraintsViewModel]
    
    init(constraints: [ConstraintsViewModel]) {
        self.constraints = constraints
    }
    
    func apply() {
        constraints.forEach { constraint in
            constraint.mainElement.translatesAutoresizingMaskIntoConstraints = false
            validateElementIsAdded(constraint.mainElement)
            decideWitchConstraintToCall(constraint)
        }
        constraints.removeAll()
    }
    
    private func validateElementIsAdded(_ mainElement: UIView) {
        if mainElement.superview == nil {
            fatalError("Element \(mainElement) is not added!")
        }
    }
    
    private func decideWitchConstraintToCall(_ constraint: ConstraintsViewModel) {
        constraint.getConstraint.mainAttribute.forEach { mainAttr in
            activateConstraint(constraint, mainAttr)
        }
    }
    
    private func activateConstraint(_ constraint: ConstraintsViewModel, _ mainAttr: ConstraintsAttribute) {
        let layoutConstraint =
        NSLayoutConstraint(item: constraint.mainElement,
                           attribute: mainAttr.toNSLayoutConstraintAttribute(),
                           relatedBy: constraint.relation.toNSLayoutConstraintRelation(),
                           toItem: setupToItem(constraint),
                           attribute: constraint.toAttribute?.toNSLayoutConstraintAttribute() ?? mainAttr.toNSLayoutConstraintAttribute(),
                           multiplier: constraint.multiplier,
                           constant: setupConstant(constraint, mainAttr)
        )
        
        layoutConstraint.isActive = true
    }
    
    private func setupConstant(_ constraint: ConstraintsViewModel, _ mainAttr: ConstraintsAttribute) -> CGFloat {
        if (constraint.mainAttribute.count > 1) {
            if mainAttr == .bottom || mainAttr == .trailing {
                let const = constraint.constant ?? 0
                return (const > 0) ? -const : 0.0
            }
        }
        return constraint.constant ?? 0
    }
    
    private func setupToItem(_ constraint: ConstraintsViewModel) -> Any? {
        if constraint.typeElement == .safeArea {
            return toItemSafeArea(constraint.mainElement)
        }
        if constraint.typeElement == .superView {
            return toItemSuperView(constraint.mainElement)
        }
        return constraint.toItem
    }
    
    private func toItemSafeArea(_ mainElement: UIView) -> Any? {
        guard let safeArea = mainElement.superview?.safeAreaLayoutGuide else { return nil }
        return safeArea
    }
    
    private func toItemSuperView(_ mainElement: UIView) -> Any? {
        guard let superView = mainElement.superview else { return nil}
        return superView
    }
    
    
}
