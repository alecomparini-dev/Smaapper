//
//  OnTapGesture.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/05/23.
//

import Foundation

//
//  TapGesture.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/05/23.
//

import UIKit

internal class OnTapGesture: UITapGestureRecognizer {
    var touchPosition: CGPoint?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else { return }
        self.touchPosition = touch.location(in: self.view?.window)
        self.state = .began
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else { return }
        self.touchPosition = touch.location(in: self.view?.window)
        self.state = .changed
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        guard let touch = touches.first else { return }
        self.touchPosition = touch.location(in: self.view?.window)
        self.state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        self.touchPosition = nil
        self.state = .cancelled
    }
    

}
