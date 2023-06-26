//
//  HighIntensityDollView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

class HighIntensityDollView: ViewBuilder {
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
    
//  MARK: - LAZY Area
    lazy var doll: ImageViewBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "figure.highintensity.intervaltraining"))
            .setContentMode(.scaleAspectFit)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return img
    }()
    
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        doll.add(insideTo: self.view)
    }
    
    
    private func configConstraints() {
        doll.applyConstraint()
    }
    
    
}


//  MARK: - EXTENSION GallowsDollProtocol
extension HighIntensityDollView: DollProtocol {
    func firstError() {
        
    }
    
    func secondError() {
        
    }
    
    func thirdError() {
        
    }
    
    func fourthError() {
        
    }
    
    func fifthError() {
        
    }
    
    func sixthError() {
        
    }
    


    
    
}

