//
//  WeatherView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/05/23.
//

import UIKit

protocol WeatherViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}

class WeatherView: ViewBuilder {
    
    weak var delegate: WeatherViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        configStyles()
        addElements()
        configConstraints()
    }
    
    //  MARK: - LAZY Area
    
    lazy var temperatureImageView: ImageViewBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "cloud.bolt.rain.fill"))
            .setSize(80)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
            }
        return img
    }()
    
    
    lazy var minimizeWindowButton: ButtonImageBuilder = {
        let btn = ButtonImageBuilder(UIImageView(image: UIImage(systemName: "minus.square.fill")))
            .setImageSize(14)
            .setImageWeight(.semibold)
            .setTitleAlignment(.center)
            .setImageColor(Theme.shared.currentTheme.onSurfaceVariant.withAlphaComponent(0.8))
            .setConstraints { build in
                build
                    .setSize.equalToConstant(25)
                    .setTop.equalToSuperView(7)
                    .setTrailing.equalToSuperView(-7)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(minimizeWindow), .touchUpInside)
            }
        return btn
    }()
    @objc
    private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    lazy var closeWindowButton: ButtonImageBuilder = {
        let btn = ButtonImageBuilder(UIImageView(image: UIImage(systemName: "xmark")))
            .setImageSize(10)
            .setImageWeight(.semibold)
            .setTitleAlignment(.center)
            .setImageColor(Theme.shared.currentTheme.onSurfaceVariant.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setSize.equalToConstant(25)
                    .setTop.equalToSuperView(7)
                    .setLeading.equalToSuperView(8)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(closeWindow), .touchUpInside)
            }
        return btn
    }()
    @objc
    private func closeWindow() {
        delegate?.closeWindow()
    }
    
    lazy var titleView: ViewBuilder = {
        let view = ViewBuilder()
            minimizeWindowButton.add(insideTo: view.view)
            minimizeWindowButton.applyConstraint()
            closeWindowButton.add(insideTo: view.view)
            closeWindowButton.applyConstraint()
        return view
    }()
    
    
//  MARK: - PRIVATE Area
    
    private func configStyles() {
        configBorder()
        configNeumorphism()
    }
    
    private func configBorder() {
        self.setBorder { build in
            build
                .setCornerRadius(20)
                .setWidth(0)
        }
    }
    
    private func configNeumorphism() {
        self.setNeumorphism { build in
            build
                .setReferenceColor(Theme.shared.currentTheme.surfaceContainerLow)
                .setShape(.concave)
                .setLightPosition(.leftTop)
                .setBlur(to: .light, percent: 5)
                .apply()
        }
    }
    
    private func addElements() {
        temperatureImageView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        temperatureImageView.applyConstraint()
    }
    
    

}
