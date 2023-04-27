//
//  Warning.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 14/03/23.
//

import UIKit

class Choose: AlertProtocol {
    
    private let options: [String]
    private let cancelOption: Bool
    
    init(options: [String], _ cancelOption: Bool = true) {
        self.options = options
        self.cancelOption = cancelOption
    }
    
    func present(_ title: String, _ message: String, _ completion: ((String?) -> Void)?) -> UIAlertController {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        addChoiseOptions(alertController, title, message, completion)
        addOptionCancel(alertController, completion)
        
        return alertController
    }
    
    private func addChoiseOptions(_ alertController: UIAlertController, _ title: String, _ message: String, _ completion: ((String?) -> Void)?) {
        for option in self.options {
            let action = UIAlertAction(title: option, style: .default) { action in
                completion?(option)
            }
            alertController.addAction(action)
        }
    }
    
    
    private func addOptionCancel(_ alertController: UIAlertController, _ completion: ((String?) -> Void)?) {
        if self.cancelOption {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                completion?("Cancel")
            }
            alertController.addAction(cancelAction)
        }
    }
    

}
