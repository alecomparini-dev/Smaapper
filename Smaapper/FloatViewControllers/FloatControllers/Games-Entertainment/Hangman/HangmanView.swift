//
//  HangmanView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

protocol HangmanViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}

class HangmanView: ViewBuilder {
    
    weak var delegate: HangmanViewDelegate?
    
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
    lazy var titleView: ViewBuilder = {
        let view = TitleFloatView(logo: "", title: "", target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    lazy var painelGallowsView: ViewBuilder = {
        let view = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(10)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.flat)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 80)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(titleView.view, .bottom, 5)
                    .setLeading.equalToSuperView(25)
                    .setTrailing.equalToSuperView(-20)
                    .setHeight.equalToConstant(170)
            }
        return view
    }()

    lazy var gallowsView: GallowsView = {
        let img = GallowsView()
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(13)
                    .setBottom.equalToSuperView(-18)
                    .setLeading.setTrailing.equalToSuperView
            }
        return img
    }()
 
    lazy var tipDescriptionLabel: LabelBuilder = {
        let img = LabelBuilder()
            .setColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(painelGallowsView.view, .bottom, 13)
                    .setLeading.setTrailing.equalToSuperView(15)
            }
        return img
    }()
    
    lazy var gallowsWordView: GallowsWordView = {
        let img = GallowsWordView()
            .setConstraints { build in
                build
                    .setTop.equalTo(painelGallowsView.view, .bottom, 50)
                    .setLeading.setTrailing.equalToSuperView(15)
                    .setHeight.equalToConstant(65)
            }
        return img
    }()
    
    lazy var gallowsKeyboardView: GallowsKeyboardView = {
        let img = GallowsKeyboardView()
            .setConstraints { build in
                build
                    .setTop.equalTo(gallowsWordView.view, .bottom, 15)
                    .setPinBottom.equalToSuperView(15)
            }
        return img
    }()
    
    
//  MARK: - @OBJC Area
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
        painelGallowsView.add(insideTo: self.view)
        gallowsView.add(insideTo: painelGallowsView.view)
        tipDescriptionLabel.add(insideTo: self.view)
        gallowsWordView.add(insideTo: self.view)
        gallowsKeyboardView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        painelGallowsView.applyConstraint()
        tipDescriptionLabel.applyConstraint()
        gallowsView.applyConstraint()
        gallowsWordView.applyConstraint()
        gallowsKeyboardView.applyConstraint()
    }
    
    

}

