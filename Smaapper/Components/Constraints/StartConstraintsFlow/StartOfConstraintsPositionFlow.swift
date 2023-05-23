//
//  StartOfConstraintsPositionFlow.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

class StartOfConstraintsPositionFlow<C>: StartOfConstraintsPositionFlowProtocol {
    typealias T = C
    
    
    private let constraintVM: ConstraintsViewModel
    private let constraintsFlow: StartOfConstraintsFlow

    init(_ constraintsFlow: StartOfConstraintsFlow) {
        self.constraintsFlow = constraintsFlow
        self.constraintVM = self.constraintsFlow.constraintVM
    }
    
    
//  MARK: - CONSTRAINTS POSITION FLOW
    
    var setTop: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.top)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    var setBottom: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.bottom)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    var setLeading: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.leading)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    var setTrailing: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.trailing)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }

    
//  MARK: - CONSTRAINTS SIZE FLOW
    
    var setWidth: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.width)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }
    
    var setHeight: EndOfConstraintsPositionFlowProtocol {
        constraintVM.mainAttribute(.height)
        return EndOfConstraintsPositionFlow(constraintsFlow)
    }

    
//  MARK: - CONSTRAINTS RELATIONS CONSTANT
    
    func equalTo(_ element: UIView, _ attribute: T , _ constant: CGFloat) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.equalTo(element, attribute.toConstraintsAttribute() , constant)
        }
        return constraintsFlow
    }
    
    func equalTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.equalTo(element, attribute.toConstraintsAttribute())
        }
        return constraintsFlow
    }
    
    func lessThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.lessThanOrEqualTo(element, attribute.toConstraintsAttribute() , constant)
        }
        return constraintsFlow
    }
    
    func lessThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.lessThanOrEqualTo(element, attribute.toConstraintsAttribute())
        }
        return constraintsFlow
    }
    
    
    func greaterThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.greaterThanOrEqualTo(element, attribute.toConstraintsAttribute() , constant)
        }
        return constraintsFlow
    }
    
    func greaterThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow {
        if let attribute = attribute as? ConstraintsAttributeProtocol {
            constraintVM.greaterThanOrEqualTo(element, attribute.toConstraintsAttribute())
        }
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
    
    var greaterThanOrEqualToSafeArea: StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSafearea()
        return constraintsFlow
    }
    
    func greaterThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSafearea(constant)
        return constraintsFlow
    }
    
    var lessThanOrEqualToSafeArea: StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSafearea()
        return constraintsFlow
    }
    
    func lessThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSafearea(constant)
        return constraintsFlow
    }
    
    
//  MARK: - SUPER VIEW AREA
    var equalToSuperView: StartOfConstraintsFlow {
        constraintVM.equalToSuperView()
        return constraintsFlow
    }
    
    func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.equalToSuperView(constant)
        return constraintsFlow
    }
    
    
    var greaterThanOrEqualToSuperView: StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSuperView()
        return constraintsFlow
    }
    
    func greaterThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.greaterThanOrEqualToSuperView(constant)
        return constraintsFlow
    }
    
    
    var lessThanOrEqualToSuperView: StartOfConstraintsFlow{
        constraintVM.lessThanOrEqualToSuperView()
        return constraintsFlow
    }
    
    func lessThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow {
        constraintVM.lessThanOrEqualToSuperView(constant)
        return constraintsFlow
    }
    
    
    
    
}



