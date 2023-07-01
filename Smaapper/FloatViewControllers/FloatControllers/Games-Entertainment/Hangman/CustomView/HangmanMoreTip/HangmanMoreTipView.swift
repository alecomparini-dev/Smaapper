//
//  HangmanMoreTipView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/06/23.
//

import UIKit

protocol HangmanMoreTipViewDelegate: AnyObject {
    func didSelectRow(_ section: Int, _ row: Int )
}

class HangmanMoreTipView: View {
    
    weak var delegate: HangmanMoreTipViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
//  MARK: - LAZY Area
    
    lazy var tipList: ListBuilder = {
        let list = ListBuilder(.grouped)
            .setSeparatorStyle(.none)
            .setRowHeight(40)
            .setSectionHeaderHeight(50)
            .setWidthLeftColumnCell(10)
            .setShowsVerticalScrollIndicator(false)
            .setActions({ build in
                build
                    .setDidSelectRow { [weak self] section, row in
                        self?.delegate?.didSelectRow(section, row)
                    }
            })
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return list
    }()
    
//    lazy var closeMoreTipButton: ButtonImageBuilder = {
//        <#statements#>
//        return <#value#>
//    }()
    
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        tipList.add(insideTo: self)
    }
    
    private func configConstraints() {
        tipList.applyConstraint()
    }
    
    
}
