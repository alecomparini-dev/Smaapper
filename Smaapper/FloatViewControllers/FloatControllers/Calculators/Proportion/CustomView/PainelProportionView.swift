//
//  PainelProportionView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 13/06/23.
//

import UIKit

class PainelProportionView: ViewBuilder {
    
    private var listTextFields: [UITextField] = []
    private var initialIndex: Int = 0
    
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

    
    lazy var resultLabel: LabelBuilder = {
        let label = LabelBuilder("0.0")
            .setFont(UIFont.systemFont(ofSize: 18, weight: .semibold))
            .setColor(Theme.shared.currentTheme.onSurface)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setLeading.setTrailing.equalToSuperView
            }
        return label
    }()
    
    lazy var viewResult: ViewBuilder = {
        let view = ViewBuilder()
        view.view.layer.masksToBounds = true
        return view
    }()
    
    lazy var underLineResult: ViewBuilder = {
       var view = ViewBuilder()
            .setGradient({ build in
                build
                    .setGradientColors(Theme.shared.currentTheme.primaryGradient)
                    .setAxialGradient(.leftToRight)
                    .apply()
            })
            .setBorder({ build in
                build.setCornerRadius(2)
            })
            .setShadow({ build in
                build
                    .setOffset(width: 3, height: 3)
                    .setColor(.black.withAlphaComponent(0.8))
                    .setOpacity(1)
                    .setRadius(3)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(textFieldC.view, .bottom )
                    .setLeading.setTrailing.equalToSuperView(5)
                    .setHeight.equalToConstant(2)
            }
        return view
    }()
    
    
//  MARK: - TEXTFIELDS Area
    
    lazy var textFieldA: TextFieldBuilder = {
        let txt = defaultTextField("A")
        listTextFields.append(txt.view)
        return txt
    }()
    
    lazy var textFieldB: TextFieldBuilder = {
        let txt = defaultTextField("B")
        listTextFields.append(txt.view)
        return txt
    }()
    
    lazy var textFieldC: TextFieldBuilder = {
        let txt = defaultTextField("C")
        listTextFields.append(txt.view)
        return txt
    }()
    

//  MARK: - PUBLIC Area
    func configDelegate(_ delegate: TextFieldDelegate) {
        textFieldA.setDelegate(delegate)
        textFieldB.setDelegate(delegate)
        textFieldC.setDelegate(delegate)
    }
    
    
//  MARK: - PRIVATE Area
    
    private func defaultTextField(_ placeHolder: String) -> TextFieldBuilder {
        let txt = TextFieldBuilder(placeHolder)
            .setKeyboard({ buid in
                buid
                    .setKeyboardType(.decimalPad)
                    .setClearButton()
                    .setNavigationButtonTextField {
                        return self.listTextFields
                    }
            })
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
        
        viewA.add(insideTo: stackHorizontal1.view)
        viewB.add(insideTo: stackHorizontal1.view)
        viewC.add(insideTo: stackHorizontal2.view)
        viewResult.add(insideTo: stackHorizontal2.view)
        
        resultLabel.add(insideTo: viewResult.view)
        underLineResult.add(insideTo: viewResult.view)
        
        textFieldA.add(insideTo: viewA.view)
        textFieldB.add(insideTo: viewB.view)
        textFieldC.add(insideTo: viewC.view)

    }
    
    private func configContraints() {
        stackVertical.applyConstraint()
        textFieldA.applyConstraint()
        textFieldB.applyConstraint()
        textFieldC.applyConstraint()
        
        resultLabel.applyConstraint()
        underLineResult.applyConstraint()
    }
    

}
