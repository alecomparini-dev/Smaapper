//
//  AlcoholOrGasolineView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/07/23.
//

import UIKit
import Speech

protocol AlcoholOrGasolineViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}


class AlcoholOrGasolineView: ViewBuilder {
    
    weak var delegate: AlcoholOrGasolineViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        configStyles()
        addElements()
        configConstraints()
    }
    
    lazy var titleView: ViewBuilder = {
        let view = TitleFloatView(logo: K.Alcohol.Images.logo, title: K.Alcohol.title, target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    
    //  MARK: - PUBLIC Area
    
    
    
    
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
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
    }
    
    
//  MARK: - OBJCT Area
    
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    @objc private func closeWindow() {
        delegate?.closeWindow()
    }
    
}



