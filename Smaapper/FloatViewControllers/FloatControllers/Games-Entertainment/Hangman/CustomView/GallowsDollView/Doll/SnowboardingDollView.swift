//
//  SnowboardingDollView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

class SnowboardingDollView: ViewBuilder {
    
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
        let img = ImageViewBuilder(UIImage(systemName: "figure.snowboarding"))
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
extension SnowboardingDollView: DollProtocol {

    func head() {
            
    }
    
    func torso() {
        
    }
    
    func rightArm() {
        
    }
    
    func leftArm() {
        
    }
    
    func rightLeg() {
        
    }
    
    func leftLeg() {
        
    }
    
    
}


