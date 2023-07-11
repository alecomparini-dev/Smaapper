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
    func okButton()
    func copyButton()
    func refreshButton()
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
        let view = TitleFloatView(logo: K.Proportion.Images.logo, title: K.Proportion.title, target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    lazy var painel: PainelProportionView = {
        let view = PainelProportionView()
            .setConstraints { build in
                build
                    .setTop.equalTo(okButton.view, .top, -6)
                    .setTrailing.equalTo(okButton.view, .leading, -13)
                    .setLeading.equalToSuperView(13)
                    .setBottom.equalTo(okButton.view, .bottom)
            }
        return view
    }()
    
    lazy var stackViewButtons: StackBuilder = {
        let stack = StackBuilder()
            .setHidden(true)
            .setAxis(.vertical)
            .setSpacing(14)
            .setDistribution(.fillEqually)
            .setConstraints { build in
                build
                    .setTop.equalTo(titleView.view, .bottom, 10)
                    .setTrailing.equalToSuperView(-14)
                    .setBottom.equalTo(historyButton.view, .top, -10)
                    .setWidth.equalToConstant(44)
            }
        return stack
    }()
    
    lazy var refreshButton: ButtonImageBuilder = {
        let btn = self.defaultButtonImage(K.Proportion.Images.refresh)
            .setActions { build in
                build
                    .setTarget(self, #selector(refreshButtonTapped), .touchUpInside)
            }
        defaultNeumorphism(btn.view)
        return btn
    }()

    lazy var copyButton: ButtonImageBuilder = {
        let btn = self.defaultButtonImage(K.Proportion.Images.copy)
            .setTintColor(Theme.shared.currentTheme.primary)
            .setActions { build in
                build
                    .setTarget(self, #selector(copyButtonTapped), .touchUpInside)
            }
        defaultNeumorphism(btn.view)
        return btn
    }()
    
    lazy var okButton: ButtonBuilder = {
        let btn = ButtonBuilder(K.Proportion.labelOkButton)
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
                    .setTop.equalTo(titleView.view, .bottom, 10)
                    .setTrailing.equalToSuperView(-14)
                    .setBottom.equalTo(historyButton.view, .top, -10)
                    .setWidth.equalToConstant(44)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(okButtonTapped), .touchUpInside)
            }
        defaultNeumorphism(btn.view)
        return btn
    }()

    lazy var historyButton: ButtonImageBuilder = {
        let img = UIImageView(image: UIImage(systemName: K.Proportion.Images.history))
        let btn = ButtonImageBuilder(img)
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setImageSize(12)
            .setImageWeight(.thin)
            .setImagePlacement(.all)
            .setBorder({ build in
                build
                    .setCornerRadius(7)
            })
            .setGradient({ build in
                build
                    .setAxialGradient(.rightBottomToLeftTop)
                    .setGradientColors([Theme.shared.currentTheme.surfaceContainerHighest,
                                        Theme.shared.currentTheme.surfaceContainerLow])
                    .apply()
            })
            .setConstraints { build in
                build
                    .setHorizontalAlignmentX.equalToSuperView
                    .setBottom.equalToSuperView(-8)
                    .setWidth.equalToConstant(55)
                    .setHeight.equalToConstant(15)
            }
        return btn
    }()
    
    
//  MARK: - PUBLIC Area
    func setTextFieldDelegate(_ delegate: TextFieldDelegate) {
        painel.configDelegate(delegate)
    }
    
    func setPainelDelegate(_ delegate: PainelProportionViewDelegate) {
        painel.delegate = delegate
    }
    
    
//  MARK: - PRIVATE Area
    
    private func defaultButtonImage(_ image: String) -> ButtonImageBuilder {
        let img = UIImageView(image: UIImage(systemName: image))
        let btn = ButtonImageBuilder(img)
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setImageSize(14)
            .setImageWeight(.thin)
            .setBorder({ build in
                build
                    .setCornerRadius(5)
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
        historyButton.add(insideTo: self.view)
        titleView.add(insideTo: self.view)
        painel.add(insideTo: self.view)
        stackViewButtons.add(insideTo: self.view)
        refreshButton.add(insideTo: stackViewButtons.view)
        copyButton.add(insideTo: stackViewButtons.view)
        okButton.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        painel.applyConstraint()
        okButton.applyConstraint()
        historyButton.applyConstraint()
        stackViewButtons.applyConstraint()
    }
    
    
//  MARK: - OBJCT Area
    
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    @objc private func closeWindow() {
        delegate?.closeWindow()
    }
    
    @objc private func okButtonTapped() {
        delegate?.okButton()
    }
    
    @objc private func copyButtonTapped() {
        delegate?.copyButton()
    }
    
    @objc private func refreshButtonTapped() {
        delegate?.refreshButton()
    }
    
}



