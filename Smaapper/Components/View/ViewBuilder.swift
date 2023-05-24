//
//  ViewBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class ViewBuilder: BaseAttributeBuilder {
    
    private var _view: View
    var view: View { self._view }
    
    init() {
        self._view = View(frame: .zero)
        super.init(_view)
    }
    
    init(frame: CGRect) {
        self._view = View(frame: frame)
        super.init(_view)
    }
    
}
