//
//  GallowsKeyboardView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/06/23.
//

import UIKit

protocol GallowsKeyboardViewDelegate: AnyObject {
    func letterKeyboardTapped(_ letter: String)
}

class GallowsKeyboardView: ViewBuilder {
    weak var delegate: GallowsKeyboardViewDelegate?
    
    private let spacingHorizontal: CGFloat = 8
    private let lettersOfKeyboard: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","Ç"]
    
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
    
    
//  MARK: - LAZY HINT

    lazy var hintButton: DefaultFloatViewButton = {
        let btn = DefaultFloatViewButton(Theme.shared.currentTheme.tertiary, "More tip ...")
        btn.button.setTitleColor(Theme.shared.currentTheme.onPrimary, .normal)
            .setTintColor(Theme.shared.currentTheme.onPrimary)
            .setTitleSize(14)
        return btn
    }()
    
    
//  MARK: - PRIVATE Area
    
    private func addElements() {
        addStackElements()
        addLetterToHorizontalStacks()
        addHintToRightHorizontalStack1()
    }
    
    private func addHintToRightHorizontalStack1() {
        hintButton.add(insideTo: rightHorizontalStack1.view)
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
        lettersOfKeyboard.enumerated().forEach { index,letter in
            switch index {
            case 0...5:
                addLetterToHorizontalStack(letter, stack: horizontalStack5)
            
            case 6...11:
                addLetterToHorizontalStack(letter, stack: horizontalStack4)
                
            case 12...17:
                addLetterToHorizontalStack(letter, stack: horizontalStack3)
                
            case 18...23:
                addLetterToHorizontalStack(letter, stack: horizontalStack2)
                
            case 24...26:
                addLetterToHorizontalStack(letter, stack: leftHorizontalStack1)
                
            default:
                break
            }
        }
    }
    
    private func addLetterToHorizontalStack(_ letter: String, stack: StackBuilder) {
        let letterView = createGallowsLetterView(letter)
        letterView.add(insideTo: stack.view)
    }
    
    private func configConstraints() {
        verticalStack.applyConstraint()
    }

    private func createGallowsLetterView(_ text: String) -> GallowsLetterView {
        let letter = GallowsLetterView(text, Theme.shared.currentTheme.surfaceContainer)
        letter.gallowsLetter.button.setTitleSize(14)
        letter.gallowsLetter.button.setActions { build in
            build
                .setTarget(self, #selector(letterTapped), .touchUpInside)
        }
        return letter
    }
    
    @objc private func letterTapped(_ sender: UIButton) {
        delegate?.letterKeyboardTapped(sender.titleLabel?.text ?? "")
    }
    
}

