//
//  ViewBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class ViewBuilder: BaseBuilder {
    
    var view: View
    
    init() {
        self.view = View(frame: .zero)
        super.init(self.view)
    }
    
    init(frame: CGRect) {
        self.view = View(frame: frame)
        super.init(self.view)
    }
    
}
