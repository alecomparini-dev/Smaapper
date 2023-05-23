//
//  OverlayAttributes.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import UIKit


class OverlayAttributes: BaseComponentAttributes<Overlay> {
    
    private var _relativeTo: Overlay.RelativeTo = .window
    
    private weak var overlay: Overlay?
    
    override init(_ overlay: Overlay) {
        self.overlay = overlay
        super.init(overlay)
    }
    
    override init() {
        super.init()
    }
    
    
//  MARK: - GET Attributes
    var relativeTo: Overlay.RelativeTo { self._relativeTo}
    
    
//  MARK: - SET Attributes
    @discardableResult
    func setColor(_ color: UIColor) -> Self {
        self.overlay?.setBackgroundColor(color)
        return self
    }
    
    @discardableResult
    func setOpacity(_ opacity: CGFloat) -> Self {
        self.overlay?.alpha = opacity
        return self
    }
    
    @discardableResult
    func setOverlayRelative(to relativeTo: Overlay.RelativeTo) -> Self {
        self._relativeTo = relativeTo
        return self
    }
    
}

