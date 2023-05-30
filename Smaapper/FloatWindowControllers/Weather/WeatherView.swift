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
        addElements()
        configConstraints()
        
        setBorder { build in
            build
                .setCornerRadius(20)
                .setWidth(0)
        }
        
        
        setNeumorphism { build in
            build
                .setReferenceColor(Theme.shared.currentTheme.surfaceContainerLowest)
                .setShape(.concave)
                .setLightPosition(.leftTop)
                .setBlur(to: .light, percent: 5)
                .apply()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func addElements() {
        temperatureImageView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        temperatureImageView.applyConstraint()
    }
    
    
}
