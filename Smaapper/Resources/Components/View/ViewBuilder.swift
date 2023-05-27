//
//  ViewBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class ViewBuilder: BaseBuilder {
    
    private(set) var view: View
    
    init() {
        self.view = View(frame: .zero)
        super.init(view)
    }
    
    init(frame: CGRect) {
        self.view = View(frame: frame)
        super.init(view)
    }
    
}
