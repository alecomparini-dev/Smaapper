//
//  BaseViewModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 28/03/23.
//

import UIKit

class BaseViewModel {

    private var model = BaseModel()
    
//    var constraints: Constraints? {
//        get { model.constraints }
//        set { model.constraints = newValue }
//    }
    
    var userInteractionEnabled: Bool? {
        get { model.userInteractionEnabled }
        set { model.userInteractionEnabled = newValue }
    }
    
    var backgroundColor: UIColor? {
        get { model.backgroundColor }
        set { model.backgroundColor = newValue }
    }
    
    var gradient: Gradient? {
        get { model.gradient }
        set { model.gradient = newValue }
    }
    
}
