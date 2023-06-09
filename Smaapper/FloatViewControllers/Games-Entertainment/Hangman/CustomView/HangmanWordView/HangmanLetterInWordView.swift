//
//  HangmanLetterInWordView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/06/23.
//

import UIKit

class HangmanLetterInWordView: ViewBuilder {
    
    private let letter: String
    
    init(_ letter: String) {
        self.letter = letter
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
    
//  MARK: - LAZY Area
    
    lazy var label: LabelBuilder = {
        let label = LabelBuilder(letter)
            .setHidden(true)
            .setFont(UIFont.systemFont(ofSize: 20, weight: .regular))
            .setColor(Theme.shared.currentTheme.onSurface)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return label
    }()
    
    lazy var underlineLetter: ViewBuilder = {
        let view = ViewBuilder()
            .setGradient({ build in
                build
                    .setGradientColors([Theme.shared.currentTheme.surfaceContainerHigh, Theme.shared.currentTheme.surfaceContainerHighest])
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
    }()
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        label.add(insideTo: self.view)
        underlineLetter.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        label.applyConstraint()
        underlineLetter.applyConstraint()
    }
    
    
}
