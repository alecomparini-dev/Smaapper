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
    
    private func createCloseWindowButton() -> ButtonBuilder {
        let btn = ButtonBuilder()
            .setGradient({ build in
                build
                    .setGradientColors([UIColor.HEX("#d32739"), UIColor.HEX("#d32739")])
                    .apply()
            })
            .setShadow({ build in
                build
                    .setColor(.black)
                    .setRadius(5)
                    .setOpacity(0.6)
                    .setOffset(width: 5, height: 5)
                    .apply()
            })
            .setBorder { build in
                build
                    .setCornerRadius(8)
//                    .setWidth(2)
            }
            .setConstraints { build in
                build
                    .setSize.equalToConstant(16)
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
                .setTrailing.equalToSuperView(-12)
                .setVerticalAlignmentY.equalToSuperView(5)
                .apply()
        }
        
    }
    
}
