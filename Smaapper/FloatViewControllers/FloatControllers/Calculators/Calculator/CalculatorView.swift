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
        let view = TitleFloatView(logo: "", title: "", target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    
//  MARK: - DISPLAY Area
    
    lazy var display: LabelBuilder = {
        let label = LabelBuilder("123.456.789.0")
//            .setBackgroundColor(.red)
            .setTextAlignment(.right)
            .setFont(UIFont.systemFont(ofSize: 33, weight: .thin))
            .setColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setTop.equalTo(titleView.view, .bottom, 3)
                    .setLeading.setTrailing.equalToSuperView(13)
                    .setHeight.equalToConstant(50)
            }
        return label
    }()
    
    
    lazy var lineSeparator: ViewBuilder = {
       var view = ViewBuilder()
            .setGradient({ build in
                build
                    .setGradientColors(Theme.shared.currentTheme.primaryGradient)
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
                    .setTop.equalTo(display.view, .bottom)
                    .setLeading.setTrailing.equalToSuperView(15)
                    .setHeight.equalToConstant(2)
            }
        return view
    }()
    
//  MARK: - BUTTONS
    lazy var buttonsView: CalculatorButtonsView = {
        let view = CalculatorButtonsView()
            .setConstraints { build in
                build
                    .setTop.equalTo(lineSeparator.view, .bottom, 13)
                    .setLeading.setBottom.equalToSuperView(15)
                    .setTrailing.equalToSuperView(-12)
            }
        return view
    }()


//  MARK: - BUTTONS Area


    
    
    
//  MARK: - PRIVATE Area
    
    private func configStyles() {
        configBorder()
        configNeumorphism()
    }
    
    private func configBorder() {
        self.setBorder { build in
            build.setCornerRadius(20)
        }
    }
    
    private func configNeumorphism() {
        UtilsFloatView.configNeumorphisFloatView(self)
    }
    
    private func addElements() {
        display.add(insideTo: self.view)
        titleView.add(insideTo: self.view)
        buttonsView.add(insideTo: self.view)
        lineSeparator.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        display.applyConstraint()
        titleView.applyConstraint()
        buttonsView.applyConstraint()
        lineSeparator.applyConstraint()
    }
    
    
//  MARK: - @OBJC Area
    
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    @objc private func closeWindow() {
        delegate?.closeWindow()
    }
    
}
