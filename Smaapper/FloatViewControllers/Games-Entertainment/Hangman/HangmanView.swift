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
    func nextWord()
}

class HangmanView: ViewBuilder {
    
    weak var delegate: HangmanViewDelegate?
    private(set) var hangmanMoreTipViewController: HangmanMoreTipViewController?
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        configStyles()
        addElements()
        configConstraints()
    }
    
    deinit {
        hangmanMoreTipViewController = nil
        delegate = nil
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
                    .setDistance(to: .light, percent: 5)
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
    
    lazy var nextWordButton: IconButtonBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: K.Hangman.Images.nextWordButton))
        let btn = IconButtonBuilder(img.view)
            .setHidden(true)
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setImageSize(20)
            .setTitleSize(13)
            .setImagePadding(3)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(painelGallowsView.view)
                    .setTrailing.equalTo(painelGallowsView.view, .trailing, -3)
                    .setWidth.equalToConstant(50)
                    .setHeight.equalToConstant(35)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(nextWord), .touchUpInside)
            }
        return btn
    }()

    lazy var gallowsView: GallowsView = {
        let view = createHangmanGallowsView()
        return view
    }()
 
    lazy var tipDescriptionLabel: LabelBuilder = {
        let label = LabelBuilder()
            .setColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(painelGallowsView.view, .bottom, 13)
                    .setLeading.setTrailing.equalToSuperView(15)
            }
        return label
    }()
    
    lazy var gallowsWordView: HangmanWordView = {
        let view = createHangmanWordView()
        return view
    }()
    
    lazy var gallowsKeyboardView: HangmanKeyboardView = {
        let img = HangmanKeyboardView()
            .setConstraints { build in
                build
                    .setHeight.equalToConstant(190)
                    .setPinBottom.equalToSuperView(15)
            }
        return img
    }()
    
    lazy var moreTipView: ViewBuilder = {
        let view = ViewBuilder()
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainerHigh)
            .setBorder({ build in
                build
                    .setCornerRadius(15)
            })
            .setHidden(true)
        return view
    }()
    

//  MARK: - ACTION
    
    func createHangmanMoreTipViewController(_ tips: [String]) {
        hangmanMoreTipViewController = HangmanMoreTipViewController(tips)
            .setConstraints { build in
                build.setPin.equalToSuperView
            }
        hangmanMoreTipViewController?.add(insideTo: moreTipView.view)
        hangmanMoreTipViewController?.applyConstraint()
    }
    
    func resetGallowsView() {
        gallowsView.view.removeFromSuperview()
        gallowsView = createHangmanGallowsView()
        addGallowsView()
        configGallowsViewContraints()
    }
    
    func resetGallowsWordView() {
        gallowsWordView.view.removeFromSuperview()
        gallowsWordView = createHangmanWordView()
        addGallowsWordView()
        configGallowsWordViewContraints()
    }
    
    func resetHangmanMoreTipViewController() {
        hangmanMoreTipViewController?.view.removeFromSuperview()
        hangmanMoreTipViewController = nil
    }
    
    
//  MARK: - @OBJC Area
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    @objc private func closeWindow() {
        delegate?.closeWindow()
    }
    
    @objc private func nextWord() {
        delegate?.nextWord()
    }
    
    
//  MARK: - PRIVATE Area
    
    private func createHangmanGallowsView() -> GallowsView {
        let view = GallowsView()
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(13)
                    .setBottom.equalToSuperView(-18)
                    .setLeading.setTrailing.equalToSuperView
            }
        return view
    }
    
    private func createHangmanWordView() -> HangmanWordView {
        let view = HangmanWordView()
            .setConstraints { build in
                build
                    .setTop.equalTo(painelGallowsView.view, .bottom, 45)
                    .setLeading.setTrailing.equalToSuperView(15)
                    .setHeight.equalToConstant(65)
            }
        return view
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
        Utils.configNeumorphisFloatView(self)
    }
    
    private func addElements() {
        titleView.add(insideTo: self.view)
        painelGallowsView.add(insideTo: self.view)
        addGallowsView()
        nextWordButton.add(insideTo: self.view)
        tipDescriptionLabel.add(insideTo: self.view)
        addGallowsWordView()
        gallowsKeyboardView.add(insideTo: self.view)
        moreTipView.add(insideTo: self.view)
    }
    
    private func addGallowsView() {
        gallowsView.add(insideTo: painelGallowsView.view)
    }
    
    private func addGallowsWordView() {
        gallowsWordView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        painelGallowsView.applyConstraint()
        configGallowsViewContraints()
        nextWordButton.applyConstraint()
        tipDescriptionLabel.applyConstraint()
        configGallowsWordViewContraints()
        gallowsKeyboardView.applyConstraint()
    }
    
    private func configGallowsViewContraints() {
        gallowsView.applyConstraint()
    }
    
    private func configGallowsWordViewContraints() {
        gallowsWordView.applyConstraint()
    }
    

    

}

