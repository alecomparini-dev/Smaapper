//
//  StartOfConstraintsFlowProtocol.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 18/04/23.
//

import UIKit

class StartOfConstraintsFlow: StartOfConstraintsFlowProtocol {
    private let mainElement: UIView
    private var _constraintVM: ConstraintsViewModel?
    private var listConstraints: [ConstraintsViewModel] = []

    init(_ mainElement: UIView) {
        self.mainElement = mainElement
    }
    
    var constraintVM: ConstraintsViewModel {
        get { self._constraintVM ?? ConstraintsViewModel()   }
        set { self._constraintVM = newValue }
    }
    
//  MARK: - CONSTRAINTS POSITION FLOW
    
    var setTop: StartOfConstraintsPositionFlow<ConstraintsPositionY> {
        configStartFlow()
        constraintVM.mainAttribute(.top)
        return StartOfConstraintsPositionFlow<ConstraintsPositionY>(self)
    }
    
    var setBottom: StartOfConstraintsPositionFlow<ConstraintsPositionY> {
        configStartFlow()
        constraintVM.mainAttribute(.bottom)
        return StartOfConstraintsPositionFlow<ConstraintsPositionY>(self)
    }
    var setLeading: StartOfConstraintsPositionFlow<ConstraintsPositionX> {
        configStartFlow()
        constraintVM.mainAttribute(.leading)
        return StartOfConstraintsPositionFlow<ConstraintsPositionX>(self)
    }
    var setTrailing: StartOfConstraintsPositionFlow<ConstraintsPositionX> {
        configStartFlow()
        constraintVM.mainAttribute(.trailing)
        return StartOfConstraintsPositionFlow<ConstraintsPositionX>(self)
    }

    
//  MARK: - CONSTRAINTS SIZE FLOW
    
    var setWidth: StartOfConstraintsSizeFlowProtocol {
        configStartFlow()
        constraintVM.mainAttribute(.width)
        return StartOfConstraintsSizeFlow(self)
    }
    
    var setHeight: StartOfConstraintsSizeFlowProtocol {
        configStartFlow()
        constraintVM.mainAttribute(.height)
        return StartOfConstraintsSizeFlow(self)
    }

    
//  MARK: - CONSTRAINTS ALIGNMENTS
    
    var setHorizontalAlignmentX: StartOfConstraintsAlignmentFlowProtocol {
        configStartFlow()
        constraintVM.mainAttribute(.horizontalX)
        return StartOfConstraintsAlignmentFlow(self)
    }
    
    var setVerticalAlignmentY: StartOfConstraintsAlignmentFlowProtocol {
        configStartFlow()
        constraintVM.mainAttribute(.verticalY)
        return StartOfConstraintsAlignmentFlow(self)
    }
    
    
//  MARK: - INITIATE VIEWMODEL
    
    private func configStartFlow() {
        self.startViewModel()
        self.addConstraintFlow()
        self.setMainElement()
    }
    
    private func startViewModel() {
        self.constraintVM = ConstraintsViewModel()
    }
    
    private func addConstraintFlow() {
        self.listConstraints.append(self.constraintVM)
    }
    
    private func setMainElement() {
        self.constraintVM.mainElement = self.mainElement
    }
    
    func applyConstraint() {
        let applyConstraint = ApplyConstraints(constraints: listConstraints)
        applyConstraint.apply()
        listConstraints.removeAll()
        _constraintVM = nil
    }
    
}


