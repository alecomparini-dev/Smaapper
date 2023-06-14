//
//  PainelProportionView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 13/06/23.
//

import UIKit

class PainelProportionView: ViewBuilder {
    
    override init() {
        super.init()
        addElements()
        configContraints()
    }
    
    
//  MARK: - STACK VIEW Area

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
            .setSpacing(10)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var stackHorizontal2: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(10)
            .setDistribution(.fillEqually)
        return stack
    }()

    
//  MARK: - VIEW Area
    lazy var viewA: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()

    lazy var viewB: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewC: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()

    lazy var viewResult: ViewBuilder = {
        let view = ViewBuilder()
        view.view.layer.masksToBounds = true
        let label = LabelBuilder("0.0")
            .setFont(UIFont.systemFont(ofSize: 18, weight: .semibold))
            .setColor(Theme.shared.currentTheme.primary)
            .setTextAlignment(.center)
            .setConstraints { build in
                build.setAlignmentCenterXY.equalToSuperView
                    .setLeading.setTrailing.equalToSuperView
            }
        label.add(insideTo: view.view)
        label.applyConstraint()
        
        return view
    }()
    
    
    
//  MARK: - TEXTFIELDS Area
    
    lazy var textFieldA: TextFieldBuilder = {
        let txt = defaultTextField("A")
            
        return txt
    }()
    
    lazy var textFieldB: TextFieldBuilder = {
        let txt = defaultTextField("B")
        return txt
    }()
    
    lazy var textFieldC: TextFieldBuilder = {
        let txt = defaultTextField("C")
        return txt
    }()
    
    
    
//  MARK: - PRIVATE Area
    
    private func defaultTextField(_ placeHolder: String) -> TextFieldBuilder {
        let txt = TextFieldBuilder(placeHolder)
            .setKeyboardType(.decimalPad)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainerHighest)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setAlignment(.center)
            .setTextColor(Theme.shared.currentTheme.onSurface)
            .setPlaceHolderColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setFont(UIFont.systemFont(ofSize: 14, weight: .medium))
            .setBorder({ build in
                build
                    .setCornerRadius(5)
            })
            .setConstraints { build in
                build
                    .setLeading.setTrailing.equalToSuperView
                    .setVerticalAlignmentY.equalToSuperView
                    .setHeight.equalToConstant(35)
            }
        return txt
    }
    
    private func addElements() {
        stackVertical.add(insideTo: self.view)
        stackHorizontal1.add(insideTo: stackVertical.view)
        stackHorizontal2.add(insideTo: stackVertical.view)
        
        textFieldA.add(insideTo: viewA.view)
        textFieldB.add(insideTo: viewB.view)
        textFieldC.add(insideTo: viewC.view)
        
        viewA.add(insideTo: stackHorizontal1.view)
        viewB.add(insideTo: stackHorizontal1.view)
        viewC.add(insideTo: stackHorizontal2.view)
        viewResult.add(insideTo: stackHorizontal2.view)
        
    }
    
    private func configContraints() {
        stackVertical.applyConstraint()
        textFieldA.applyConstraint()
        textFieldB.applyConstraint()
        textFieldC.applyConstraint()
    }
    
}
