//
//  WhatFlowerView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/07/23.
//

import UIKit

protocol WhatFlowerViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}


class WhatFlowerView: ViewBuilder {
    weak var delegate: WhatFlowerViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        configStyles()
        addElements()
        configConstraints()
    }
    
    deinit {
        print(#function, #fileID)
    }
    
    
    //  MARK: - LAZY Area
    lazy var titleView: ViewBuilder = {
        let view = TitleFloatView(logo: K.TapeMeasure.Images.logo, title: K.TapeMeasure.title, target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    lazy var cameraARKit: ARSceneViewBuilder = {
        let arKit = ARSceneViewBuilder()
            .setAlignmentTarget(.top, 100)
            .setPlaneDetection([.vertical, .horizontal])
            .setBorder { build in
                build
                    .setCornerRadius(20)
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(titleView.view, .bottom, 5)
                    .setPinBottom.equalToSuperView
            }
        return arKit
    }()
    

    
//  MARK: - OBJCT Area
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    @objc private func closeWindow() {
        delegate?.closeWindow()
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
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        cameraARKit.applyConstraint()
    }
    
}
