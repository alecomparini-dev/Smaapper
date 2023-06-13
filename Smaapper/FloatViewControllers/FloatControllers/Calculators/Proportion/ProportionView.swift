//
//  ProportionView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

protocol ProportionViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}

class ProportionView: ViewBuilder {
    
    weak var delegate: ProportionViewDelegate?
    
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
        let view = TitleFloatView(logo: "3.square.fill", title: "Proportion", target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
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
    
    lazy var painelProportion: PainelProportionView = {
        let view = PainelProportionView()
            .setConstraints { build in
                build
                    .setTop.equalTo(titleView.view, .bottom, 20)
                    .setTrailing.equalToSuperView(-70)
                    .setLeading.setBottom.equalToSuperView(15)
            }
        return view
    }()
    
    lazy var stackViewButtons: StackBuilder = {
        let stack = StackBuilder()
            .setHidden(true)
            .setAxis(.vertical)
            .setSpacing(12)
            .setDistribution(.fillEqually)
            .setConstraints { build in
                build
                    .setTop.equalTo(titleView.view, .bottom, 20)
                    .setBottom.equalTo(threePointsButton.view, .top, -15)
                    .setLeading.setTrailing.equalTo(threePointsButton.view, 6)
            }
        return stack
    }()
    
    lazy var refreshButton: ButtonImageBuilder = {
        let btn = self.defaultButtonImage("arrow.counterclockwise")
        defaultNeumorphism(btn.view)
        return btn
    }()
    
    lazy var saveButton: ButtonImageBuilder = {
        let btn = self.defaultButtonImage("square.and.arrow.down")
        defaultNeumorphism(btn.view)
        return btn
    }()
    
    lazy var okButton: ButtonBuilder = {
        let btn = ButtonBuilder("Ok")
            .setHidden(false)
            .setFont(UIFont.systemFont(ofSize: 12, weight: .semibold))
            .setTitleColor(Theme.shared.currentTheme.onSurface, .normal)
            .setTitleColor(Theme.shared.currentTheme.onSurfaceVariant, .disabled)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setTitleAlignment(.center)
            .setBorder({ build in
                build
                    .setCornerRadius(10)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(titleView.view, .bottom, 20)
                    .setBottom.equalTo(threePointsButton.view, .top, -15)
                    .setLeading.equalTo(threePointsButton.view, .leading, 3)
                    .setTrailing.equalTo(threePointsButton.view, .trailing, -1)
            }
        defaultNeumorphism(btn.view)
        return btn
    }()
    
    lazy var threePointsButton: ButtonImageBuilder = {
        let btn = self.defaultButtonImage("ellipsis")
            .setBorder({ build in
                build
                    .setCornerRadius(9)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.convex)
                    .setLightPosition(.leftTop)
                    .setBlur(percent: 0)
                    .setDistance(percent: 0)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setBottom.equalToSafeArea(-10)
                    .setTrailing.equalToSafeArea(-10)
                    .setWidth.equalToConstant(47)
                    .setHeight.equalToConstant(18)
            }
        return btn
    }()
    
    
//  MARK: - PRIVATE Area
    
    private func defaultButtonImage(_ image: String) -> ButtonImageBuilder {
        let img = UIImageView(image: UIImage(systemName: image))
        let btn = ButtonImageBuilder(img)
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setImageSize(14)
            .setImageWeight(.thin)
            .setImagePlacement(.all)
            .setBorder({ build in
                build
                    .setCornerRadius(10)
            })
        return btn
    }
    
    private func defaultNeumorphism(_ component: UIView) {
        NeumorphismBuilder(component)
            .setReferenceColor(Theme.shared.currentTheme.surfaceContainerHigh)
            .setShape(.concave)
            .setLightPosition(.leftTop)
            .setIntensity(to: .light, percent: 80)
            .setBlur(to: .light, percent: 3)
            .setBlur(to: .dark, percent: 5)
            .setDistance(to: .light, percent: 3)
            .apply()
    }
    
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
        threePointsButton.add(insideTo: self.view)
        titleView.add(insideTo: self.view)
        painelProportion.add(insideTo: self.view)
        stackViewButtons.add(insideTo: self.view)
        refreshButton.add(insideTo: stackViewButtons.view)
        saveButton.add(insideTo: stackViewButtons.view)
        okButton.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        painelProportion.applyConstraint()
        okButton.applyConstraint()
        threePointsButton.applyConstraint()
        stackViewButtons.applyConstraint()
    }
    
    
}
