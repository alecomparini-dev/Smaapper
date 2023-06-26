//
//  GallowsKeyboardView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/06/23.
//

import UIKit

class GallowsKeyboardView: ViewBuilder {
    
    private let spacingHorizontal: CGFloat = 8
    
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
            .setAlignment(.fill)
            .setSpacing(8)
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
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var leftHorizontalStack1: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var rightHorizontalStack1: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack2: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack3: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack4: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack5: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    

//  MARK: - LAZY WORDS Area
    
    lazy var letterA: GallowsLetterView = {
        let letter = getGallowsLetterView("A")
        return letter
    }()
    
    lazy var letterB: GallowsLetterView = {
        let letter = getGallowsLetterView("B")
        return letter
    }()
    
    lazy var letterC: GallowsLetterView = {
        let letter = getGallowsLetterView("C")
        return letter
    }()
    
    lazy var letterD: GallowsLetterView = {
        let letter = getGallowsLetterView("D")
        return letter
    }()
    
    lazy var letterE: GallowsLetterView = {
        let letter = getGallowsLetterView("E")
        return letter
    }()
    
    lazy var letterF: GallowsLetterView = {
        let letter = getGallowsLetterView("F")
        return letter
    }()
    
    lazy var letterG: GallowsLetterView = {
        let letter = getGallowsLetterView("G")
        return letter
    }()
    
    lazy var letterH: GallowsLetterView = {
        let letter = getGallowsLetterView("H")
        return letter
    }()
    
    lazy var letterI: GallowsLetterView = {
        let letter = getGallowsLetterView("I")
        return letter
    }()
    
    lazy var letterJ: GallowsLetterView = {
        let letter = getGallowsLetterView("J")
        return letter
    }()
    
    lazy var letterK: GallowsLetterView = {
        let letter = getGallowsLetterView("K")
        return letter
    }()
    
    lazy var letterL: GallowsLetterView = {
        let letter = getGallowsLetterView("L")
        return letter
    }()
    
    lazy var letterM: GallowsLetterView = {
        let letter = getGallowsLetterView("M")
        return letter
    }()
    
    lazy var letterN: GallowsLetterView = {
        let letter = getGallowsLetterView("N")
        return letter
    }()
    
    lazy var letterO: GallowsLetterView = {
        let letter = getGallowsLetterView("O")
        return letter
    }()
    
    lazy var letterP: GallowsLetterView = {
        let letter = getGallowsLetterView("P")
        return letter
    }()
    
    lazy var letterQ: GallowsLetterView = {
        let letter = getGallowsLetterView("Q")
        return letter
    }()
    
    lazy var letterR: GallowsLetterView = {
        let letter = getGallowsLetterView("R")
        return letter
    }()
    
    lazy var letterS: GallowsLetterView = {
        let letter = getGallowsLetterView("S")
        return letter
    }()
    
    lazy var letterT: GallowsLetterView = {
        let letter = getGallowsLetterView("T")
        return letter
    }()
    
    lazy var letterU: GallowsLetterView = {
        let letter = getGallowsLetterView("U")
        return letter
    }()
    
    lazy var letterV: GallowsLetterView = {
        let letter = getGallowsLetterView("V")
        return letter
    }()
    
    lazy var letterW: GallowsLetterView = {
        let letter = getGallowsLetterView("W")
        return letter
    }()
    
    lazy var letterX: GallowsLetterView = {
        let letter = getGallowsLetterView("X")
        return letter
    }()
    
    lazy var letterY: GallowsLetterView = {
        let letter = getGallowsLetterView("Y")
        return letter
    }()
    
    lazy var letterZ: GallowsLetterView = {
        let letter = getGallowsLetterView("Z")
        return letter
    }()
    
    lazy var letterCedilha: GallowsLetterView = {
        let letter = getGallowsLetterView("Ç")
        return letter
    }()

    
//  MARK: - LAZY HINT

    lazy var hintButton: DefaultFloatViewButton = {
        let btn = DefaultFloatViewButton(Theme.shared.currentTheme.tertiary, "Hint")
        btn.button.setTitleColor(Theme.shared.currentTheme.onPrimary, .normal)
            .setTintColor(Theme.shared.currentTheme.onPrimary)
        return btn
    }()
    
    
//  MARK: - PRIVATE Area
    
    private func addElements() {
        addStackElements()
        addLetterToHorizontalStacks()
    }
    
    private func addStackElements() {
        verticalStack.add(insideTo: self.view)
        horizontalStack5.add(insideTo: verticalStack.view)
        horizontalStack4.add(insideTo: verticalStack.view)
        horizontalStack3.add(insideTo: verticalStack.view)
        horizontalStack2.add(insideTo: verticalStack.view)
        horizontalStack1.add(insideTo: verticalStack.view)
        leftHorizontalStack1.add(insideTo: horizontalStack1.view)
        rightHorizontalStack1.add(insideTo: horizontalStack1.view)
    }
    
    private func addLetterToHorizontalStacks() {
        addWordsToHorizontalStack5()
        addWordsToHorizontalStack4()
        addWordsToHorizontalStack3()
        addWordsToHorizontalStack2()
        addWordsToHorizontalStack1()
    }
    
    private func addWordsToHorizontalStack5() {
        letterA.add(insideTo: horizontalStack5.view)
        letterB.add(insideTo: horizontalStack5.view)
        letterC.add(insideTo: horizontalStack5.view)
        letterD.add(insideTo: horizontalStack5.view)
        letterE.add(insideTo: horizontalStack5.view)
        letterF.add(insideTo: horizontalStack5.view)
    }
    
    private func addWordsToHorizontalStack4() {
        letterG.add(insideTo: horizontalStack4.view)
        letterH.add(insideTo: horizontalStack4.view)
        letterI.add(insideTo: horizontalStack4.view)
        letterJ.add(insideTo: horizontalStack4.view)
        letterK.add(insideTo: horizontalStack4.view)
        letterL.add(insideTo: horizontalStack4.view)
    }
    
    private func addWordsToHorizontalStack3() {
        letterM.add(insideTo: horizontalStack3.view)
        letterN.add(insideTo: horizontalStack3.view)
        letterO.add(insideTo: horizontalStack3.view)
        letterP.add(insideTo: horizontalStack3.view)
        letterQ.add(insideTo: horizontalStack3.view)
        letterR.add(insideTo: horizontalStack3.view)
    }
    
    private func addWordsToHorizontalStack2() {
        letterS.add(insideTo: horizontalStack2.view)
        letterT.add(insideTo: horizontalStack2.view)
        letterU.add(insideTo: horizontalStack2.view)
        letterV.add(insideTo: horizontalStack2.view)
        letterW.add(insideTo: horizontalStack2.view)
        letterX.add(insideTo: horizontalStack2.view)
    }
    
    private func addWordsToHorizontalStack1() {
        letterY.add(insideTo: leftHorizontalStack1.view)
        letterZ.add(insideTo: leftHorizontalStack1.view)
        letterCedilha.add(insideTo: leftHorizontalStack1.view)
        hintButton.add(insideTo: rightHorizontalStack1.view)
    }

    private func configConstraints() {
        verticalStack.applyConstraint()
    }

    private func getGallowsLetterView(_ text: String) -> GallowsLetterView {
        let letter = GallowsLetterView(text, Theme.shared.currentTheme.surfaceContainer)
        letter.gallowsLetter.button.setTitleSize(14)
        return letter
    }
    
    
}
