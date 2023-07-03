//
//  TapeMeasureView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import UIKit

protocol TapeMeasureViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}


class TapeMeasureView: ViewBuilder {
    
    weak var delegate: TapeMeasureViewDelegate?
    
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
        let view = TitleFloatView(logo: "ruler.fill", title: "Tape Measure", target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    lazy var arKitView: TapeMeasureARKitView = {
        let arKit = TapeMeasureARKitView()
        return arKit
    }()
    


    lazy var startButtonImage: IconButtonBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "ruler"))
        let btn = IconButtonBuilder(img.view, "start")
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setImageWeight(.thin)
            .setImageSize(22)
            .setTitleSize(14)
            .setImagePadding(0)
            .setBorder({ build in
                build
                    .setCornerRadius(10)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.secondary)
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
                    .setBottom.setTrailing.equalToSuperView(15)
                    .setWidth.equalToConstant(60)
                    .setHeight.equalToConstant(50)
            }
        return btn
    }()
    
    
//  MARK: - OBJCT Area
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
        arKitView.add(insideTo: self.view)
        startButtonImage.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        configARKitViewConstraints()
        startButtonImage.applyConstraint()
    }
    
    private func configARKitViewConstraints() {
        StartOfConstraintsFlow(arKitView)
            .setTop.equalTo(titleView.view, .bottom, 10)
            .setLeading.setTrailing.equalToSuperView(10)
            .setBottom.equalToSuperView(-10)
            .apply()
    }
}
