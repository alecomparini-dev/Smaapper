//
//  EndOfConstraintsSizeFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

class EndOfConstraintsSizeFlow: EndOfConstraintsSizeFlowProtocol {
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }

    
//  MARK: - CONSTRAINTS POSITION FLOW
    var setTop: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.top)
        return self
    }
    
    var setBottom: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.bottom)
        return self
    }
    
    var setLeading: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.leading)
        return self
    }
    
    var setTrailing: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.trailing)
        return self
    }
    
    
//  MARK: - CONSTRAINTS SIZE FLOW
    var setWidth: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.width)
        return self
    }
    
    var setHeight: EndOfConstraintsSizeFlowProtocol {
        constraintVM.mainAttribute(.height)
        return self
    }
    
    
//  MARK: - CONSTRAINTS RELATIONS
    
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
