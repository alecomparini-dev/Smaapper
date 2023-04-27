//
//  Alert.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 14/03/23.
//

import UIKit

protocol AlertProtocol: AnyObject {
    func present(_ title: String, _ message: String, _ completion: ((String?) -> Void)? ) -> UIAlertController
}

class Alert<T:AlertProtocol> {
    
    private let controller: UIViewController
    private let title: String
    private let message: String
    private let typeAlert: T
    private var completion: ((String?) -> Void)?
    
    init(controller: UIViewController, title: String, message: String, typeAlert: T, completion: ((String?) -> Void)? = nil)  {
        self.controller = controller
        self.title = title
        self.message = message
        self.typeAlert = typeAlert
        self.completion = completion
    }
    
    public func present() {
        let alertController: UIAlertController = self.typeAlert.present(title, message, completion)
        self.controller.present(alertController, animated: true)
    }
    
}
