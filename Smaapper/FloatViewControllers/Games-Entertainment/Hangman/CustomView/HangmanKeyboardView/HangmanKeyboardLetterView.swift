//
//  HangmanKeyboardLetterView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/06/23.
//

import UIKit

protocol HangmanKeyboardLetterViewDelegate: AnyObject {
    func letterKeyboardTapped(_ letter: HangmanKeyboardLetterView)
}


class HangmanKeyboardLetterView: ViewBuilder {
    weak var delegate: HangmanKeyboardLetterViewDelegate?
    
    private let color: UIColor
    private(set) var text: String
    private(set) var buttonInteration: ButtonInteraction?
    
    init(_ text: String, _ color: UIColor) {
        self.text = text
        self.color = color
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
        configButtonInteraction()
    }
    
    
//  MARK: - LAZY Area
    
    lazy var gallowsLetter: DefaultFloatViewButton = {
        let button = createLetter()
        return button
    }()
    
    
//  MARK: - ACTION
    func resetKeyboardLetterView() {
        gallowsLetter.view.removeFromSuperview()
        gallowsLetter = createLetter()
        initialization()
    }
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        gallowsLetter.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        gallowsLetter.applyConstraint()
    }
    
    private func configButtonInteraction() {
        self.buttonInteration = ButtonInteraction(self.gallowsLetter.outlineView.view)
        
    }
    
    private func createLetter() -> DefaultFloatViewButton{
        let button = DefaultFloatViewButton(self.color, self.text)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        button.button.setActions { build in
            build
                .setTarget(self, #selector(letterTapped), .touchUpInside)
        }
        return button
    }
    
    
//  MARK: - @OBJC Area
    @objc private func letterTapped(_ sender: UIButton) {
        delegate?.letterKeyboardTapped(self)
    }
    
}
