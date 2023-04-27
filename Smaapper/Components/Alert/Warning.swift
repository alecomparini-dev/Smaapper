//
//  Warning.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 14/03/23.
//

import UIKit

class Warning: AlertProtocol {
    
    func present(_ title: String, _ message: String, _ completion: ((String?) -> Void)?) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            completion?(nil)
        })
        
        alertController.addAction(ok)
        
        return alertController
    }

}
