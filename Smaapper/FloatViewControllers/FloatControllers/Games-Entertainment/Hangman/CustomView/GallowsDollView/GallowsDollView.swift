//
//  GallowsDollView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/06/23.
//

import UIKit

class GallowsDollView: ViewBuilder {
    
    private let doll: DollProtocol
    
    init(_ doll: DollProtocol) {
        self.doll = doll
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
    lazy var dollView: ViewBuilder = {
        let view = self.doll
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return view
    }()
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        dollView.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        dollView.applyConstraint()
    }

}


//  MARK: - EXTENSION DollProtocol

extension GallowsDollView: DollProtocol {
    
    func firstError() {
        self.doll.firstError()
    }
    
    func secondError() {
        self.doll.secondError()
    }
    
    func thirdError() {
        self.doll.thirdError()
    }
    
    func fourthError() {
        self.doll.fourthError()
    }
    
    func fifthError() {
        self.doll.fifthError()
    }
    
    func sixthError() {
        self.doll.sixthError()
    }

    func showDollSuccess() {
        self.doll.showDollSuccess()
    }
    
    func showDollFailure() {
        self.doll.showDollFailure()
    }
    
}
