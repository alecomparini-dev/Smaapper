//
//  ShadowViewModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 25/03/23.
//

import UIKit

class ShadowViewModel {
    
    private var model = ShadowModel()

    var radius: Int {
        get { model.radius }
        set { model.radius = newValue }
    }
    
    var opacity: Float {
        get { model.opacity }
        set { model.opacity = newValue }
    }
    
    var color: UIColor {
        get { model.color }
        set { model.color = newValue }
    }
    
    var thickness: Int? {
        get { getThickness() }
        set { model.thickness = newValue }
    }
    
    var viewStyle: Shadow.ViewStyle {
        get { model.viewStyle }
        set { model.viewStyle = newValue }
    }
        
    var offset: CGSize { model.offset }
    func offset(_ width: Int, _ height: Int) {
        model.offset = CGSize(width: width, height: height)
    }
    
    private func getThickness() -> Int? {
        if let thickness = model.thickness {
            return (model.viewStyle == .innerView) ? thickness * -1 : thickness
        }
        return nil
    }
    
}
