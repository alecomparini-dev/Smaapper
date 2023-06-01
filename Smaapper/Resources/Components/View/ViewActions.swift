//
//  ViewActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit


class ViewActions: BaseActions {
    
    private let viewBuilder: ViewBuilder
    
    init(_ viewBuilder: ViewBuilder) {
        self.viewBuilder = viewBuilder
        super.init(self.viewBuilder)
    }
    
}

