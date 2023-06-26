//
//  FallDollView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

class FallDollView: ViewBuilder {
    
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
        let img = ImageViewBuilder(UIImage(systemName: "figure.fall"))
            .setContentMode(.scaleAspectFit)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(-8)
                    .setLeading.equalToSuperView(9)
                    .setWidth.equalToConstant(130)
                    .setHeight.equalToSuperView
                    
            }
        return img
    }()
    
    lazy var torsoView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
//            .setHidden(true)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.cyan.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(21)
//                    .setHorizontalAlignmentX.equalToSuperView(14)
                    .setLeading.equalToSuperView(49)
                    .setWidth.equalToConstant(28)
                    .setHeight.equalToConstant(33)
            }
        return view
    }()
    
    lazy var rightArmView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
//            .setHidden(true)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.red.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalTo(torsoView.view, .top)
                    .setLeading.equalToSuperView(10)
                    .setTrailing.equalTo(torsoView.view, .leading)
                    .setHeight.equalTo(torsoView.view)
            }
        return view
    }()
    
    lazy var leftArmView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
//            .setHidden(true)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.systemPink.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(-2)
                    .setLeading.equalTo(torsoView.view, .leading, 10)
                    .setTrailing.equalToSuperView(-5)
                    .setBottom.equalTo(torsoView.view, .top, 1)
            }
        return view
    }()
    
    lazy var rightLegView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
//            .setHidden(true)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.red.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalTo(torsoView.view, .bottom)
                    .setLeading.equalTo(torsoView.view, .leading)
                    .setTrailing.equalTo(leftLegView.view, .trailing)
                    .setBottom.equalToSafeArea
            }
        return view
    }()
    
    lazy var leftLegView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
//            .setHidden(true)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
//            .setBackgroundColor(.orange.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setTop.equalTo(torsoView.view, .top)
                    .setLeading.equalTo(torsoView.view, .trailing)
                    .setWidth.equalToConstant(38)
                    .setBottom.equalTo(torsoView.view, .bottom)
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
extension FallDollView: DollProtocol {
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

