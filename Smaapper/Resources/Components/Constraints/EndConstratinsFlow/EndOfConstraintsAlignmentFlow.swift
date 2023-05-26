//
//  EndOfConstraintsAlignmentFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

class EndOfConstraintsAlignmentFlow: EndOfConstraintsAlignmentFlowProtocol {
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }
    
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow {
        constraintVM.equalTo(element)
        return constraintsFlow
    }
    
    var equalToSafeArea: StartOfConstraintsFlow {
        constraintVM.equalToSafeArea()
        return constraintsFlow
    }
    
    var equalToSuperView: StartOfConstraintsFlow {
        constraintVM.equalToSuperView()
        return constraintsFlow
    }
    
}
