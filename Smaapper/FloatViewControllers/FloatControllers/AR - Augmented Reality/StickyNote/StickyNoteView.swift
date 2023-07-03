//
//  StickyNoteView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 03/07/23.
//

import UIKit

protocol StickyNoteViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}


class StickyNoteView: ViewBuilder {
    
    weak var delegate: StickyNoteViewDelegate?
    
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
        let view = TitleFloatView(logo: K.Sticky.Images.logo, title: K.Sticky.title, target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
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
}
