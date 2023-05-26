//
//  WeatherForecastView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/05/23.
//

import UIKit


class WeatherForecastView: ViewBuilder {
    
    private var temperature: CGFloat
    
    init(temperature: CGFloat) {
        self.temperature = temperature
        super.init()
        addElements()
        configConstraints()
        setBackgroundColor(.cyan)
    }
    
    
//  MARK: - Lazy Area
    
    lazy var weatherImageView: ImageViewBuilder = {
        let img = ImageViewBuilder()
            .setImage(UIImage(systemName: "cloud.sun.rain.fill"))
            .setSize(35)
            .setTintColor(.white)
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setLeading.equalToSuperView(15)
                    .setVerticalAlignmentY.equalToSuperView
            }
        return img
    }()
    
    
    
//  MARK: - Private Area
    
    private func addElements() {
        weatherImageView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        weatherImageView.applyConstraint()
    }
    
}

