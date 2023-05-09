//
//  TapGesture.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 09/05/23.
//

import UIKit

class TapGesture {
    typealias closureTapAlias = (_ gesture: TapGesture) -> Void
    
    private var tapAction: closureTapAlias?
    private let component: UIView
    private var onTapGesture: OnTapGesture?
    
    init(_ component: UIView) {
        self.component = component
    }
    
    func setOnTap(completion: @escaping closureTapAlias) -> Self {
        self.tapAction = completion
        self.component.isUserInteractionEnabled = true
//        self.onTapGesture = OnTapGesture(target: self, action: #selector(ontapped))
//        self.onTapGesture!.cancelsTouchesInView = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(ontapped))
        tap.cancelsTouchesInView = false
        tap.numberOfTapsRequired = 1
        self.component.addGestureRecognizer(tap)
        return self
    }
    
    var touchPosition: CGPoint {
        guard let touchPosition = self.onTapGesture?.touchPosition else { return CGPoint() }
        return touchPosition
    }
    
    @objc
    private func ontapped() {
        print("taaaa chamannnnnnnnnnnnnnnnndooooooooooooooooooooooo")
        tapAction?(self)
    }
}
