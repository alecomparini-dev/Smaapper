//
//  HangmanWordView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/06/23.
//

import UIKit

class HangmanWordView: ViewBuilder {
    
    private let spacingHorizontal: CGFloat = 2
    private let spacingVertical: CGFloat = 0
    
    private var word: [String] = []
    
    override init() {
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
            .setHidden(true)
            .setAxis(.horizontal)
            .setAlignment(.center)
            .setSpacing(spacingHorizontal)
            .setDistribution(.equalCentering)
        return stack
    }()
    
    
//  MARK: - SET PROPERTIES
    
    func createWord(_ word: String) -> [HangmanLetterInWordView] {
        var letters: [HangmanLetterInWordView] = []
        word.forEach { letter in
            letters.append(createLetter(String(letter)))
        }
        return letters
    }
    
    func insertLetterInStack(_ letter: HangmanLetterInWordView, _ horizontalStack: StackBuilder) {
        letter.add(insideTo: horizontalStack.view)
        letter.applyConstraint()
    }
    
    func insertSpaceInStack(_ horizontalStack: StackBuilder) {
        let space = space()
        space.add(insideTo: horizontalStack.view)
        space.applyConstraint()
    }

    func revealLetterInWord(_ letter: HangmanLetterInWordView) {
        configLetterForAnimation(letter)
        revealLetterInWordAnimation(letter)
    }
    
    private func configLetterForAnimation(_ letter: HangmanLetterInWordView) {
        letter.label.setHidden(false)
        letter.label.setAlpha(0)
        letter.underlineLetter.gradient?.setReferenceColor(Theme.shared.currentTheme.primary, percentageGradient: -20)
            .apply()
        letter.underlineLetter.setAlpha(0)
    }
    
    private func revealLetterInWordAnimation(_ letter: HangmanLetterInWordView) {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            letter.label.view.alpha = 1
            letter.underlineLetter.view.alpha = 1
        })
    }
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        addStacks()
    }
    
    private func addStacks() {
        verticalStack.add(insideTo: self.view)
        horizontalStack1.add(insideTo: verticalStack.view)
        horizontalStack2.add(insideTo: verticalStack.view)
    }
    
    private func configConstraints() {
        verticalStack.applyConstraint()
    }
    
    private func createLetter(_ text: String) -> HangmanLetterInWordView {
        let letter = HangmanLetterInWordView(text)
            .setConstraints { build in
                build
                    .setWidth.equalToConstant(22)
                    .setHeight.equalToConstant(26)
            }
        return letter
    }
    
    private func space() -> ViewBuilder {
        let space = ViewBuilder()
            .setConstraints { build in
                build
                    .setWidth.equalToConstant(8)
                    .setHeight.equalToConstant(26)
            }
        return space
    }
    
    
}
