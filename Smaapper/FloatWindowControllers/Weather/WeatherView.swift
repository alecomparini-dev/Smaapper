//
//  WeatherView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/05/23.
//

import UIKit

class WeatherView: ViewBuilder {
    
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
        configDraggable()
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
    
    
    func createTitleView() -> UIView {
        let view = UIView()
        let closeWin = createCloseWindowButton()
//        let dragDropView = createDragDropView()
        addElementsInTitleView(view, [closeWin.view])
        configButtonsConstraintsInTitleView(closeWin)
        return view
    }
    
    private func createCloseWindowButton() -> ButtonImageBuilder {
        let btn = ButtonImageBuilder(UIImageView(image: UIImage(systemName: "xmark")))
            .setImageSize(11)
            .setImageWeight(.semibold)
            .setTitleAlignment(.center)
            .setImageColor(Theme.shared.currentTheme.onSurfaceVariant.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setSize.equalToConstant(25)
            }
        return btn
    }
    
    private func createDragDropView() -> UIView {
        let view = View()
        return view
    }
    
    private func addElementsInTitleView(_ view: UIView, _ elements: [UIView]) {
        elements.forEach { elem in
            elem.add(insideTo: view)
        }
    }
    
    private func configButtonsConstraintsInTitleView( _ closeWin: ButtonBuilder) {
        closeWin.applyConstraint()
        closeWin.setConstraints { make in
            make
                .setTop.equalToSuperView(6)
                .setTrailing.equalToSuperView(-8)
                .apply()
        }
        
    }
    
    private func configDraggable() {
        self.setDraggable()
    }
    
}
