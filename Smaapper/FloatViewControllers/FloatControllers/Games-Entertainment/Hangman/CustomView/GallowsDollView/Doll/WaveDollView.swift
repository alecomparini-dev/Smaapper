//
//  WaveDollView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

class WaveDollView: ViewBuilder {
    
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
        let img = ImageViewBuilder(UIImage(systemName: "figure.wave"))
            .setHidden(true)
            .setContentMode(.scaleAspectFit)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(-2)
                    .setBottom.equalToSuperView
                    .setLeading.equalToSuperView(-4)
                    .setTrailing.equalToSuperView
            }
        return img
    }()
    
    lazy var torsoView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(22)
                    .setHorizontalAlignmentX.equalToSuperView
                    .setWidth.equalToConstant(22)
                    .setHeight.equalToConstant(37)
            }
        return view
    }()
    
    lazy var rightArmView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView
                    .setLeading.equalToSuperView(10)
                    .setTrailing.equalTo(torsoView.view, .leading)
                    .setHeight.equalToConstant(35)
            }
        return view
    }()
    
    lazy var leftArmView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
            .setConstraints { build in
                build
                    .setTop.equalTo(torsoView.view, .top)
                    .setLeading.equalTo(torsoView.view, .trailing)
                    .setTrailing.equalToSuperView(-5)
                    .setHeight.equalTo(torsoView.view)
            }
        return view
    }()
    
    lazy var rightLegView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
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
            .setHidden(false)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
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
    
//  MARK: - ANIMATION Area
    private func showBodyPartAnimation(_ bodyPart: UIView, alpha: (start: CGFloat, end: CGFloat) = (1,0)) {
        bodyPart.alpha = alpha.start
        UIView.animate(withDuration: 0.5, delay: 0 , options: .curveEaseInOut, animations: {
            bodyPart.alpha = alpha.end
        })
    }
    
}


//  MARK: - EXTENSION GallowsDollProtocol
extension WaveDollView: DollProtocol {
    func firstError() {
        doll.setHidden(false)
        showBodyPartAnimation(doll.view, alpha: (start: 0, end: 1))
    }
    
    func secondError() {
        torsoView.setAlpha(1)
        showBodyPartAnimation(torsoView.view)
    }
    
    func thirdError() {
        showBodyPartAnimation(leftArmView.view)
    }
    
    func fourthError() {
        showBodyPartAnimation(leftLegView.view)
    }
    
    func fifthError() {
        showBodyPartAnimation(rightLegView.view)
    }
    
    func sixthError() {
        showBodyPartAnimation(rightArmView.view)
    }
    
}

