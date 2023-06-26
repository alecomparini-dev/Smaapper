//
//  DefaultDollView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

class DefaultDollView: ViewBuilder {
    private let hide = false
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
//        setBackgroundColor(.red.withAlphaComponent(0.4))
    }
    
    
//  MARK: - LAZY Area
    lazy var doll: ImageViewBuilder = {
        let img = UIImage(systemName: "figure.mixed.cardio")
        let imgView = ImageViewBuilder(img)
            .setContentMode(.scaleAspectFit)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return imgView
    }()
    
    lazy var torsoView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(true)
//            .setHidden(hide)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.yellow.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(21)
                    .setHorizontalAlignmentX.equalToSuperView
                    .setWidth.equalToConstant(30)
                    .setHeight.equalToConstant(37)
            }
        return view
    }()
    
    lazy var rightArmView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(true)
            .setHidden(hide)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.red.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(5)
                    .setLeading.equalToSuperView(5)
                    .setTrailing.equalTo(torsoView.view, .leading, 6.5)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    lazy var leftArmView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(true)
            .setHidden(hide)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.systemPink.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(5)
                    .setLeading.equalTo(torsoView.view, .trailing, -6.5)
                    .setTrailing.equalToSuperView(-5)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    lazy var rightLegView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(true)
            .setHidden(hide)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.red.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalTo(torsoView.view, .bottom)
                    .setLeading.equalToSuperView(5)
                    .setTrailing.equalTo(torsoView.view, .leading, 13)
                    .setBottom.equalToSafeArea
            }
        return view
    }()
    
    lazy var leftLegView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(true)
            .setHidden(hide)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.cyan.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalTo(torsoView.view, .bottom)
                    .setLeading.equalTo(torsoView.view, .trailing, -13)
                    .setTrailing.equalToSuperView(-5)
                    .setBottom.equalToSafeArea
            }
        return view
    }()
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        doll.add(insideTo: self.view)
        rightArmView.add(insideTo: self.view)
        leftArmView.add(insideTo: self.view)
        torsoView.add(insideTo: self.view)
        rightLegView.add(insideTo: self.view)
        leftLegView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        doll.applyConstraint()
        rightArmView.applyConstraint()
        leftArmView.applyConstraint()
        torsoView.applyConstraint()
        rightLegView.applyConstraint()
        leftLegView.applyConstraint()
    }
    
}


//  MARK: - EXTENSION GallowsDollProtocol
extension DefaultDollView: DollProtocol {
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
