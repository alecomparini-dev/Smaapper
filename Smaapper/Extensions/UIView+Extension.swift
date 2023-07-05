//
//  UIView+Extension.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit

extension UIView {
    
    var convertToImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
