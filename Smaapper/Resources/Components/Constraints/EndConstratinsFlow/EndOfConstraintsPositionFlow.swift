//
//  EndOfConstraintsPositionFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

class EndOfConstraintsPositionFlow: EndOfConstraintsPositionFlowProtocol {
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }
    
    var setTop: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.top)
        return self
    }
    
    var setBottom: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.bottom)
        return self
    }
    
    var setLeading: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.leading)
        return self
    }
    
    var setTrailing: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.trailing)
        return self
    }
    
    
//  MARK: - CONSTRAINTS SIZE FLOW
    var setWidth: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.width)
        return EndOfConstraintsSizeFlow(constraintsFlow)
    }
    
    var setHeight: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.height)
        return EndOfConstraintsSizeFlow(constraintsFlow)
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
