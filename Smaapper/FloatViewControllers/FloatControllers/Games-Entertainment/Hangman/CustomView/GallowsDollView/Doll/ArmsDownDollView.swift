//
//  ArmsDownDollView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

class ArmsDownDollView: ViewBuilder {
    
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
        let img = UIImage(systemName: "figure.arms.open")
        let imgView = ImageViewBuilder(img)
            .setHidden(true)
            .setContentMode(.scaleAspectFit)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(-1)
                    .setBottom.equalToSuperView
                    .setLeading.equalToSuperView
                    .setTrailing.equalToSuperView
            }
        return imgView
    }()
    
    lazy var torsoView: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(false)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(22)
                    .setHorizontalAlignmentX.equalToSuperView
                    .setWidth.equalToConstant(24)
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
                    .setTop.equalTo(torsoView.view, .top)
                    .setLeading.equalToSuperView(5)
                    .setTrailing.equalTo(torsoView.view, .leading)
                    .setHeight.equalTo(torsoView.view)
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
    
    private func showAllBodyPart() {
        doll.setHidden(false)
        torsoView.setHidden(true)
        leftArmView.setHidden(true)
        leftLegView.setHidden(true)
        rightLegView.setHidden(true)
        rightArmView.setHidden(true)
    }
    
}


//  MARK: - EXTENSION GallowsDollProtocol
extension ArmsDownDollView: DollProtocol {
    
    func firstError() {
        doll.setHidden(false)
        UtilsDoll.showBodyPartAnimation(doll.view, alpha: (start: 0, end: 1))
    }
    
    func secondError() {
        UtilsDoll.showBodyPartAnimation(torsoView.view)
    }
    
    func thirdError() {
        UtilsDoll.showBodyPartAnimation(leftArmView.view)
    }
    
    func fourthError() {
        UtilsDoll.showBodyPartAnimation(rightArmView.view)
    }
    
    func fifthError() {
        UtilsDoll.showBodyPartAnimation(leftLegView.view)
    }
    
    func sixthError() {
        UtilsDoll.showBodyPartAnimation(rightLegView.view)
    }
    
    func showDollSuccess() {
        showAllBodyPart()
        UtilsDoll.successAnimation(doll.view, doll.view.frame.origin.y + 18) { [weak self] in
            guard let self else {return}
            UtilsDoll.transitionImageAnimation(doll.view, "figure.highintensity.intervaltraining")
        }
    }
    
    func showDollFailure() {
        showAllBodyPart()
        UtilsDoll.successAnimation(doll.view, doll.view.frame.origin.y + 18) { [weak self] in
            guard let self else {return}
            doll.view.frame.origin.y = doll.view.frame.origin.y + 15
            doll.view.transform = CGAffineTransform(rotationAngle: -K.Hangman.angleDollFailure.angletoPI)
            UtilsDoll.transitionImageAnimation(doll.view, "figure.taichi")
        }
    }

    
}
