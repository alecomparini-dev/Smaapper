//
//  GallowsView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

class GallowsView: ViewBuilder {
    
    private let gallowColor: UIColor = Theme.shared.currentTheme.secondary
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
    
    
//  MARK: - LAZY Area
    
    lazy var topGallows: ViewBuilder = {
       var view = ViewBuilder()
            .setNeumorphism({ build in
                build
                    .setReferenceColor(gallowColor)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to:.light,percent: 50)
                    .setIntensity(to:.dark,percent: 100)
                    .setBlur(to:.light, percent: 0)
                    .setBlur(to:.dark, percent: 5)
                    .setDistance(to:.light, percent: 3)
                    .setDistance(to:.dark, percent: 10)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(rodGallows.view, .top, 4)
                    .setLeading.equalTo(rodGallows.view, .leading, -1)
                    .setTrailing.equalTo(baseGallows.view, .trailing, -50)
                    .setHeight.equalToConstant(8)
            }
        return view
    }()
    
    lazy var supportGallows: ViewBuilder = {
       var view = ViewBuilder()
            .setBackgroundColor(gallowColor)
            .setConstraints { build in
                build
                    .setTop.equalTo(topGallows.view, .top)
                    .setLeading.equalTo(rodGallows.view, .trailing, 20)
                    .setHeight.equalToConstant(65)
                    .setWidth.equalToConstant(8)
            }
        view.view.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4 )
        return view
    }()
    
    lazy var ropeGallows: ViewBuilder = {
        var view = ViewBuilder()
            .setNeumorphism({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.tertiary)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to:.light,percent: 0)
                    .setBlur(to:.light, percent: 0)
                    .setBlur(to:.dark, percent: 5)
                    .setDistance(to:.light, percent: 0)
                    .setDistance(to:.dark, percent: 10)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(topGallows.view, .bottom, -2)
                    .setHorizontalAlignmentX.equalTo(baseGallows.view, 15)
                    .setWidth.equalToConstant(3)
                    .setHeight.equalToConstant(23)
            }
        return view
    }()
    
    lazy var ropeCircleGallows: ImageViewBuilder = {
        let img = UIImage(systemName: "transmission")
        var view = ImageViewBuilder(img)
            .setHidden(false)
            .setContentMode(.redraw)
            .setTintColor(Theme.shared.currentTheme.primary)
            .setConstraints { build in
                build
                    .setTop.equalTo(ropeGallows.view, .bottom, -2)
                    .setHorizontalAlignmentX.equalTo(ropeGallows.view, -1)
                    .setWidth.equalToConstant(16)
                    .setHeight.equalToConstant(20)
            }
        return view
    }()
    
    lazy var rodGallows: ViewBuilder = {
       var view = ViewBuilder()
            .setNeumorphism({ build in
                build
                    .setReferenceColor(gallowColor)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 50)
                    .setIntensity(to: .dark, percent: 100)
                    .setBlur(to: .light, percent: 0)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .setDistance(to: .dark, percent: 10)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalToSuperView
                    .setBottom.equalTo(baseGallows.view, .bottom)
                    .setLeading.equalTo(baseGallows.view, .leading, 15)
                    .setWidth.equalToConstant(12)
            }
        return view
    }()
    
    lazy var baseGallows: ViewBuilder = {
       var view = ViewBuilder()
            .setNeumorphism({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainerHighest)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 50)
                    .setIntensity(to: .dark, percent: 100)
                    .setBlur(to: .light, percent: 0)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to:.light, percent: 3)
                    .setDistance(to:.dark, percent: 10)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setBottom.equalToSuperView
                    .setLeading.equalToSuperView(15)
                    .setTrailing.equalToSuperView(-20)
                    .setHeight.equalToConstant(3)
            }
        return view
    }()
    
    lazy var gallowsDollView: GallowsDollView = {
        let doll = GallowsDollView(ArmsDownDollView())
            .setHidden(false)
//            .setHidden(true)
            .setConstraints { build in
                build
                    .setHorizontalAlignmentX.equalTo(ropeGallows.view)
                    .setTop.equalToSuperView(30)
                    .setWidth.equalToConstant(100)
                    .setBottom.equalTo(baseGallows.view, .top, -15)
            }
        return doll
    }()

    
//  MARK: - PRIVATE Area
    
    private func addElements() {
        ropeGallows.add(insideTo: self.view)
        ropeCircleGallows.add(insideTo: self.view)
        supportGallows.add(insideTo: self.view)
        topGallows.add(insideTo: self.view)
        rodGallows.add(insideTo: self.view)
        baseGallows.add(insideTo: self.view)
        gallowsDollView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        baseGallows.applyConstraint()
        topGallows.applyConstraint()
        ropeGallows.applyConstraint()
        ropeCircleGallows.applyConstraint()
        rodGallows.applyConstraint()
        gallowsDollView.applyConstraint()
        supportGallows.applyConstraint()
    }
    
}
