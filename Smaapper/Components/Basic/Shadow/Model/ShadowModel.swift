//
//  ShadowModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 25/03/23.
//

import UIKit

struct ShadowModel {
    var viewStyle: Shadow.ViewStyle = Shadow.ViewStyle.outerView
    var radius: Int = 5
    var opacity: Float = 0.5
    var offset: CGSize = CGSize(width: 0, height: 0)
    var color: UIColor = UIColor.RGBA(0,0,0,0.8)
    var thickness: Int? = nil
    
}
