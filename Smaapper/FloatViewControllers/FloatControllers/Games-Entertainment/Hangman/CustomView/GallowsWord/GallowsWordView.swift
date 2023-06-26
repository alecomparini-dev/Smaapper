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
    
    private var word: [String] = []
    
    override init() {
        super.init()
        initialization()
        
        deletar()
        
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
    
    
//  MARK: - SET PROPERTIES
    
    func createWord(_ word: [String]) -> [GallowsLetterInWordView] {
        var letters: [GallowsLetterInWordView] = []
        word.forEach { letter in
            letters.append(createLetter(letter))
        }
        return letters
    }
    
    func insertLetterInStack(_ letter: ViewBuilder, _ horizontalStack: StackBuilder) {
        letter.add(insideTo: horizontalStack.view)
        letter.applyConstraint()
    }
    
    func insertSpaceInStack(_ horizontalStack: StackBuilder) {
        let space = space()
        space.add(insideTo: horizontalStack.view)
        space.applyConstraint()
    }

    func revealLetterInWord(_ letter: String) {
        
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
    
    private func createLetter(_ text: String) -> GallowsLetterInWordView {
        let letter = GallowsLetterInWordView(text)
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
    
    
    
    
    private func deletar() {
        let letters = createWord(["A","L","E","S", "S","A","N", "D","R","O", "L","U","I","Z" ])
        
        letters.enumerated().forEach { (index,letter) in
            if index < 10 {
                insertLetterInStack(letter, horizontalStack1)
            } else {
                insertLetterInStack(letter, horizontalStack2)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            letters[4].underlineLetter.gradient?.setGradientColors(Theme.shared.currentTheme.primaryGradient)
            letters[4].label.setHidden(false)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
                letters[7].underlineLetter.gradient?.setGradientColors(Theme.shared.currentTheme.primaryGradient)
                letters[7].label.setHidden(false)
                
            }
            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6 ) {
            letters[1].underlineLetter.gradient?.setGradientColors(Theme.shared.currentTheme.primaryGradient)
            letters[1].label.setHidden(false)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
                letters[10].underlineLetter.gradient?.setGradientColors(Theme.shared.currentTheme.primaryGradient)
                letters[10].label.setHidden(false)
                
            }
            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12 ) {
            letters[8].underlineLetter.gradient?.setGradientColors(Theme.shared.currentTheme.primaryGradient)
            letters[8].label.setHidden(false)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
                letters[3].underlineLetter.gradient?.setGradientColors(Theme.shared.currentTheme.primaryGradient)
                letters[3].label.setHidden(false)
                
            }
            
        }



        
    }
    
    
    
    
}
