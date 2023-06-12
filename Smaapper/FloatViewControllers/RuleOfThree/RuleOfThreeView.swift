//
//  RuleOfThreeView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

protocol RuleOfThreeViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}

class RuleOfThreeView: ViewBuilder {
    
    weak var delegate: RuleOfThreeViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        configStyles()
        addElements()
        configConstraints()
    }
    
    lazy var temperatureImageView: ImageViewBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "3.square.fill"))
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
        let view = UtilsFloatView.titleFloatView(self, #selector(minimizeWindow), #selector(closeWindow))
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
    }
    
    private func configConstraints() {
        temperatureImageView.applyConstraint()
    }
    
    
    
}
