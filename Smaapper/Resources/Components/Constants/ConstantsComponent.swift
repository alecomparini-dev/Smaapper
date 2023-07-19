//
//  ConstantsComponent.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import Foundation

struct C {
    
    struct String {
        static let empty = ""
    }
    
    struct ARSceneView {
        static let sizeTarget: CGFloat = 50
        struct Images {
            static let imageTarget = "viewfinder"
            static let imageBallTarget = "circle.fill"
        }
    }
    
    struct TextField {
        struct Clearable {
            static let paddingRight: CGFloat = 15
            struct Images {
                static let clearText = "xmark.circle.fill"
                static let clearTextSize: CGFloat = 22
            }
        }
        
        struct Password {
            static let paddingRight: CGFloat = 15
            struct Images {
                static let eyeOpen = "eye"
                static let eyeSlash = "eye.slash"
            }
        }
    }
    
    struct Neumorphism {
        static let darkShadowID = "darkShadowID"
        static let lightShadowID = "lightShadowID"
        static let shapeID = "shapeID"
    }
}
