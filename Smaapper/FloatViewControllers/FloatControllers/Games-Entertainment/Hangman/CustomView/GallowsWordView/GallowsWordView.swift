//
//  GallowsWordView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/06/23.
//

import UIKit

class GallowsWordView: ViewBuilder {
    
    private let spacingHorizontal: CGFloat = 2
    private let spacingVertical: CGFloat = 0
    
    private let word: [String]
    
    init(_ word: [String]) {
        self.word = word
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
    
//  MARK: - LAZY Area
    lazy var verticalStack: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.vertical)
            .setAlignment(.center)
            .setSpacing(spacingVertical)
            .setDistribution(.fillEqually)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return stack
    }()
    
    lazy var horizontalStack1: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setAlignment(.center)
            .setSpacing(spacingHorizontal)
            .setDistribution(.equalCentering)
        return stack
    }()
    
    lazy var horizontalStack2: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setAlignment(.center)
            .setSpacing(spacingHorizontal)
            .setDistribution(.equalCentering)
        return stack
    }()
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        addStacks()
        createWord()
    }
    
    private func addStacks() {
        verticalStack.add(insideTo: self.view)
        horizontalStack1.add(insideTo: verticalStack.view)
        horizontalStack2.add(insideTo: verticalStack.view)
    }
    
    private func configConstraints() {
        verticalStack.applyConstraint()
    }
    
    private func createLetter(_ text: String) -> ViewBuilder {
        let letter = ViewBuilder()
            .setConstraints { build in
                build
                    .setWidth.equalToConstant(22)
                    .setHeight.equalToConstant(26)
            }
        
        let label = createLabel(text)
        label.add(insideTo: letter.view)
        label.applyConstraint()
        
        let underline = createUnderlineLetter()
        underline.add(insideTo: label.view)
        underline.applyConstraint()
        
        return letter
    }
    
    private func createUnderlineLetter() -> ViewBuilder {
        let view = ViewBuilder()
             .setGradient({ build in
                 build
                     .setGradientColors([Theme.shared.currentTheme.surfaceContainer, Theme.shared.currentTheme.surfaceContainerHighest])
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
                     .setBottom.setWidth.equalToSuperView
                     .setHeight.equalToConstant(2)
             }
        return view
    }
    
    
    private func createLabel(_ text: String) -> LabelBuilder {
        let label = LabelBuilder(text)
            .setFont(UIFont.systemFont(ofSize: 20, weight: .regular))
            .setColor(Theme.shared.currentTheme.onSurface)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return label
    }
    
    
    private func createWord() {
        var letter = createLetter("A")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
        letter = createLetter("L")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
        letter = createLetter("E")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
        letter = createLetter("S")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
        letter = createLetter("S")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
        letter = createLetter("A")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
        letter = createLetter("N")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
        letter = createLetter("D")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
        letter = createLetter("R")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
        letter = createLetter("O")
        letter.add(insideTo: horizontalStack1.view)
        letter.applyConstraint()
        
//        horizontalStack2.setHidden(true)
        
        letter = createLetter("L")
        letter.add(insideTo: horizontalStack2.view)
        letter.applyConstraint()
        
        letter = createLetter("U")
        letter.add(insideTo: horizontalStack2.view)
        letter.applyConstraint()
        
        letter = createLetter("I")
        letter.add(insideTo: horizontalStack2.view)
        letter.applyConstraint()
        
        letter = createLetter("Z")
        letter.add(insideTo: horizontalStack2.view)
        letter.applyConstraint()
    }
    
}
