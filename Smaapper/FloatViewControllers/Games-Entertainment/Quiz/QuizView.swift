//
//  QuizView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import Foundation

import UIKit

protocol QuizViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}

class QuizView: ViewBuilder {
    
    weak var delegate: QuizViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        configStyles()
        addElements()
        configConstraints()
    }
    
    lazy var titleView: ViewBuilder = {
        let view = TitleFloatView(logo: "checkmark.circle.badge.questionmark.fill", title: "Quiz", target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    @objc private func closeWindow() {
        delegate?.closeWindow()
    }
    
    
//  MARK: - PRIVATE Area
    
    private func configStyles() {
        configBorder()
        configNeumorphism()
    }
    
    private func configBorder() {
        self.setBorder { build in
            build
                .setCornerRadius(20)
        }
    }
    
    private func configNeumorphism() {
        UtilsFloatView.configNeumorphisFloatView(self)
    }
    
    private func addElements() {
        titleView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
    }
    
    
}
