//
//  UpcomingHolidaysView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit


protocol UpcomingHolidaysViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
}

class UpcomingHolidaysView: ViewBuilder {
    
    weak var delegate: UpcomingHolidaysViewDelegate?
    
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
        let view = TitleFloatView(title: "Upcoming Holidays",logo: "calendar.badge.exclamationmark", target: self, closeClosure: #selector(closeWindow), minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
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
