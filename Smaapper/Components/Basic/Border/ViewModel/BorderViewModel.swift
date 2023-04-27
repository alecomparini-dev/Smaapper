//
//  BorderViewModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 25/03/23.
//

import UIKit

class BorderViewModel {

    private var model: BorderModel = BorderModel()
    
    
    var radius: Int {
        get { model.radius }
        set { model.radius = newValue }
    }
    
    var width: Int {
        get { model.width }
        set { model.width = newValue }
    }
    
    var color: UIColor {
        get { model.color }
        set { model.color = newValue }
    }
    
    var choiceAffectedCorners: [Border.Corner] {
        get { model.choiceAffectedCorners }
        set { model.choiceAffectedCorners = newValue }
    }
    

    public func selectCorners() -> CACornerMask {
        var selection: CACornerMask = []
        model.choiceAffectedCorners.forEach { corner in
            switch corner {
            case .topLeft:
                selection.insert(CACornerMask.topLeft)
            case .topRight:
                selection.insert(CACornerMask.topRight)
            case .bottomLeft:
                selection.insert(CACornerMask.bottomLeft)
            case .bottomRight:
                selection.insert(CACornerMask.bottomRight)
            case .top:
                selection.insert(CACornerMask.topLeft)
                selection.insert(CACornerMask.topRight)
            case .bottom:
                selection.insert(CACornerMask.bottomLeft)
                selection.insert(CACornerMask.bottomRight)
            case .left:
                selection.insert(CACornerMask.topLeft)
                selection.insert(CACornerMask.bottomLeft)
            case .right:
                selection.insert(CACornerMask.topRight)
                selection.insert(CACornerMask.bottomRight)
            case .diagonalUp:
                selection.insert(CACornerMask.bottomLeft)
                selection.insert(CACornerMask.topRight)
            case .diagonalDown:
                selection.insert(CACornerMask.topLeft)
                selection.insert(CACornerMask.bottomRight)
            }
        }
        return selection
    }
    
    
}
