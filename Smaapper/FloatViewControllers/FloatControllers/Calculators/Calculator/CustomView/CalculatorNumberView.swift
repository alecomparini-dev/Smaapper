//
//  CalculatorNumberView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/06/23.
//

import UIKit

class CalculatorNumberView: ViewBuilder {
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
    
//  MARK: - STACK Area

    lazy var stackVertical: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.vertical)
            .setSpacing(0)
            .setDistribution(.fillEqually)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return stack
    }()
    
    lazy var stackHorizontal1: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(0)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var stackHorizontal2: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(0)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var stackHorizontal3: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(0)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var stackHorizontal4: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(0)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var stackHorizontal5: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(0)
            .setDistribution(.fillEqually)
        return stack
    }()


    lazy var digitOne: CaculatorButtonView = {
        let view = CaculatorButtonView(Theme.shared.currentTheme.surfaceContainer, UIImageView())
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setSize.equalToConstant(60)
            }
        return view
    }()

    

//  MARK: - PRIVATE Area
    private func addElements() {
        digitOne.add(insideTo: self.view)

    }
    
    private func configConstraints() {
        digitOne.applyConstraint()
    }
    
}
