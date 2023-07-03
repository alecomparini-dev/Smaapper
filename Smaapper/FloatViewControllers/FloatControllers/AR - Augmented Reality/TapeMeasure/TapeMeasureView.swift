//
//  TapeMeasureView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/07/23.
//

import UIKit
import ARKit

protocol TapeMeasureViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}


class TapeMeasureView: ViewBuilder {
    
    weak var delegate: TapeMeasureViewDelegate?
    
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
        let view = TitleFloatView(logo: "ruler.fill", title: "Tape Measure", target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    lazy var arKitView: TapeMeasureARKitView = {
        let arKit = TapeMeasureARKitView()
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
        arKitView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        
        StartOfConstraintsFlow(arKitView)
            .setTop.equalTo(titleView.view, .bottom,5)
            .setLeading.setTrailing.equalToSuperView(20)
            .setBottom.equalToSuperView(-100)
            .apply()
    }
}
