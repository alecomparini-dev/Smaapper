//
//  WhatBeerView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/07/23.
//

import UIKit

protocol WhatBeerViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
    func captureTapped()
}


class WhatBeerView: ViewBuilder {
    weak var delegate: WhatBeerViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        configStyles()
        addElements()
        configConstraints()
    }
    
    
    //  MARK: - LAZY Area
    lazy var titleView: ViewBuilder = {
        let view = TitleFloatView(logo: K.WhatBeer.Images.logo,
                                  title: K.WhatBeer.title,
                                  target: self, closeClosure: #selector(closeWindow),
                                  minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    

    lazy var cameraARKit: ARSceneViewBuilder = {
        let imgTarget = ImageViewBuilder(UIImage(systemName: K.WhatBeer.Images.target))
            .setWeight(.thin)
        let arKit = ARSceneViewBuilder()

//TODO:- BOM EXEMPLO PARA TENTAR CORRIGIR O PROBLEMA DA BORDA E DO SHADOW
//            .setShadow({ build in
//                build
//                    .setColor(Theme.shared.currentTheme.surfaceContainerHighest)
//                    .setOffset(width: 0, height: -5)
//                    .setRadius(8)
//                    .apply()
//            })
            .setImageTarget(image: imgTarget, size: 25)
            .setAlignmentTarget(.middle, -20)
            .setEnabledTargetDraggable(false)
            .setBorder { build in
                build
                    .setCornerRadius(20)
                    .setWhichCornersWillBeRounded([.bottom])
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(titleView.view, .bottom, 5)
                    .setPinBottom.equalToSuperView
            }
        return arKit
    }()
    
    lazy var captureImage: ButtonImageBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: K.WhatBeer.Images.captureButton))
            .setContentMode(.center)
        let btn = ButtonImageBuilder(img.view)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setImageWeight(.thin)
            .setImageSize(22)
            .setImagePadding(0)
            .setBorder({ build in
                build
                    .setCornerRadius(10)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.secondary.withAlphaComponent(0.9))
                    .setShape(.convex)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 80)
                    .setIntensity(to: .dark, percent: 90)
                    .setDistance(percent: 0)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setBottom.setTrailing.equalToSuperView(15)
                    .setWidth.setHeight.equalToConstant(50)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(captureTapped), .touchUpInside)
            }
        return btn
    }()
    
    lazy var showResult: ViewBuilder = {
        let view = ViewBuilder()
            .setHidden(true)
            .setConstraints { build in
                build
                    .setTop.equalTo(cameraARKit.view, .top, 35)
                    .setPinBottom.equalToSuperView(35)
            }
        return view
    }()
    
    
//  MARK: - OBJCT Area
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    @objc private func closeWindow() {
        delegate?.closeWindow()
    }
    
    @objc private func captureTapped() {
        delegate?.captureTapped()
    }
    
    
//  MARK: - PRIVATE Area
    private func configStyles() {
        configBorder()
        configNeumorphism()
    }
    
    private func configBorder() {
        self.setBorder { build in
            build
                .setCornerRadius(20)
        }
    }
    
    private func configNeumorphism() {
        UtilsFloatView.configNeumorphisFloatView(self)
    }
    
    private func addElements() {
        titleView.add(insideTo: self.view)
        cameraARKit.add(insideTo: self.view)
        captureImage.add(insideTo: self.view)
        showResult.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        cameraARKit.applyConstraint()
        captureImage.applyConstraint()
        showResult.applyConstraint()
    }
    
}
