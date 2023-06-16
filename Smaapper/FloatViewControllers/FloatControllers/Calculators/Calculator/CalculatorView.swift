//
//  CalculatorView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/06/23.
//

import UIKit

protocol CalculatorViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}

class CalculatorView: ViewBuilder {
    
    weak var delegate: CalculatorViewDelegate?
    
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
        let view = TitleFloatView(logo: "equal.square.fill", title: "Calculator", target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    lazy var digitOne: CaculatorButtonView = {
        let view = CaculatorButtonView(Theme.shared.currentTheme.surfaceContainer, UIImageView())
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(100)
                    .setLeading.equalToSuperView(30)
                    .setSize.equalToConstant(50)
            }
        return view
    }()
    
    lazy var digit2: CaculatorButtonView = {
        let view = CaculatorButtonView(Theme.shared.currentTheme.surfaceContainer, UIImageView())
            .setConstraints { build in
                build
                    .setTop.equalTo(digitOne.view, .top)
                    .setLeading.equalTo(digitOne.view, .trailing, 15)
                    .setSize.equalToConstant(50)
            }
        return view
    }()

    
    
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
        digitOne.add(insideTo: self.view)
        digit2.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        digitOne.applyConstraint()
        digit2.applyConstraint()
    }
    
    
//  MARK: - OBJCT Area
    
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    @objc private func closeWindow() {
        delegate?.closeWindow()
    }
    
}
