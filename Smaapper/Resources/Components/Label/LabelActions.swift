//
//  LabelActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit


class LabelAction: BaseActions {
    
    private let labelBuilder: LabelBuilder
    
    init(_ labelBuilder: LabelBuilder) {
        self.labelBuilder = labelBuilder
        super.init(self.labelBuilder)
    }
    
}
