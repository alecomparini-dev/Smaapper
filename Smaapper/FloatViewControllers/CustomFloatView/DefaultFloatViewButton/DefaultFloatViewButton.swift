//
//  CalculatorButtonView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/06/23.
//

import UIKit

class DefaultFloatViewButton: ViewBuilder {
    
    private let cornerRadiusOutline: CGFloat = 7
    private let marginInner: CGFloat = 4.0
    
    private let colorButton: UIColor
    private var image: UIImageView = UIImageView()
    private var text: String = ""
    
    init(_ colorButton: UIColor, _ image: UIImageView) {
        self.colorButton = colorButton
        self.image = image
        super.init()
        initialization()
    }

    convenience init(_ colorButton: UIColor) {
        self.init(colorButton, UIImageView())
    }

    init(_ colorButton: UIColor, _ text: String) {
        self.colorButton = colorButton
        self.text = text
        super.init()
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//  MARK: - PRIVATE Area
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    

//  MARK: - LAZY Area
    
    lazy var outlineView: ViewBuilder = {
        let view = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(cornerRadiusOutline)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(colorButton)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 80)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return view
    }()
    
    lazy var button: ButtonImageBuilder = {
        var btn = ButtonImageBuilder(self.image)
            .setImagePadding(0)
            .setTitle(self.text, .normal)
            .setTitleColor(Theme.shared.currentTheme.onSurface, .normal)
            .setTintColor(Theme.shared.currentTheme.onSurface.adjustBrightness(-20))
            .setTitleAlignment(.center)
            .setTitleSize(16)
            .setImageSize(12)
            .setTitleWeight(.regular)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return btn
    }()
    
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        outlineView.add(insideTo: self.view)
        button.add(insideTo: self.outlineView.view)
    }
    
    private func configConstraints() {
        outlineView.applyConstraint()
        button.applyConstraint()
    }
    
}
