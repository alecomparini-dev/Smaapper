//
//  GallowsWordView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/06/23.
//

import UIKit


class GallowsLetterView: ViewBuilder {
    
    private let text: String
    private let color: UIColor
    
    init(_ text: String, _ color: UIColor) {
        self.text = text
        self.color = color
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
    
//  MARK: - LAZY Area
    
    lazy var gallowsLetter: DefaultFloatViewButton = {
        let button = DefaultFloatViewButton(self.color, self.text)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return button
    }()
    

//  MARK: - PRIVATE Area
    private func addElements() {
        gallowsLetter.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        gallowsLetter.applyConstraint()
    }
    
}
