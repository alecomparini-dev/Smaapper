//
//  Button3D.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 29/04/23.
//

import UIKit


class Button3D: Button {
    
    
    override init() {
        super.init()
        buildShadow3D()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func buildShadow3D() {
        
    }
    
}
