//
//  ConstantsComponent.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import Foundation

struct C {
    
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
}
