//
//  CaculatorButtonView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/06/23.
//

import UIKit



class CaculatorButtonView: ViewBuilder {
    
    private let colorButton: UIColor
    private let image: UIImageView
    
    init(_ colorButton: UIColor, _ image: UIImageView) {
        self.colorButton = colorButton
        self.image = image
        super.init()
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    

//  MARK: - LAZY Area
    
    lazy var outlineView: ViewBuilder = {
        let view = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(7)
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
    
    lazy var innerView: ViewBuilder = {
        print(colorButton.adjustBrightness(-30).toHexString)
        let view = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(21)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(colorButton)
                    .setShape(.concave)
                    .setLightPosition(.rightTop)
                    .setBlur(percent: 0)
                    .setDistance(percent: 0)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setPin.equalToSuperView(4)
            }
        return view
    }()
    
    lazy var button: ButtonBuilder = {
        let btn = ButtonBuilder()
            .setTitle("1", .normal)
            .setTitleColor(Theme.shared.currentTheme.onSurface, .normal)
            .setTintColor(Theme.shared.currentTheme.onSurface.adjustBrightness(-20))
            .setTitleAlignment(.center)
            .setTitleSize(18)
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
        innerView.add(insideTo: self.outlineView.view)
        button.add(insideTo: self.innerView.view)
    }
    
    private func configConstraints() {
        outlineView.applyConstraint()
        innerView.applyConstraint()
        button.applyConstraint()
    }
    
}
