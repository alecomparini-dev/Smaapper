//
//  StartOfConstraintsAlignmentFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

class StartOfConstraintsAlignmentFlow: StartOfConstraintsAlignmentFlowProtocol {
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }
    
    
//  MARK: - CONSTRAINTS ALIGNMENTS
    
    var setHorizontalAlignmentX: EndOfConstraintsAlignmentFlowProtocol {
        constraintVM.mainAttribute(.horizontalX)
        return EndOfConstraintsAlignmentFlow(constraintsFlow)
    }
    
    var setVerticalAlignmentY: EndOfConstraintsAlignmentFlowProtocol {
        constraintVM.mainAttribute(.verticalY)
        return EndOfConstraintsAlignmentFlow(constraintsFlow)
    }
    
    
//  MARK: - CONSTRAINTS RELATIONS
    
    
    func equalTo(_ element: UIView, _ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalTo(element, constant)
        return constraintsFlow
    }
    
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow {
        constraintVM.equalTo(element)
        return constraintsFlow
    }
    
    var equalToSafeArea: StartOfConstraintsFlow {
        constraintVM.equalToSafeArea()
        return constraintsFlow
    }
    func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalToSafeArea(constant)
        return constraintsFlow
    }
    
    var equalToSuperView: StartOfConstraintsFlow {
        constraintVM.equalToSuperView()
        return constraintsFlow
    }
    
    func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalToSuperView(constant)
        return constraintsFlow
    }
    
    
}
