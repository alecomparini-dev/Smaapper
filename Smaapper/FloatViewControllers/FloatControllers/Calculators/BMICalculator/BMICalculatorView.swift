//
//  BMICalculatorView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

protocol BMICalculatorViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}

class BMICalculatorView: ViewBuilder {
    
    weak var delegate: BMICalculatorViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    
    private func initialization() {
        configStyles()
        addElements()
        configConstraints()
    }
    
    //  MARK: - LAZY Area
    
    lazy var temperatureImageView: ImageViewBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "scalemass.fill"))
            .setSize(80)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
            }
        return img
    }()
    
    
    lazy var titleView: ViewBuilder = {
        let view = TitleFloatView(title: "BMI Calculator", logo: "scalemass.fill", target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView
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
        temperatureImageView.add(insideTo: self.view)
        titleView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        temperatureImageView.applyConstraint()
        titleView.applyConstraint()
    }
    
    

}
