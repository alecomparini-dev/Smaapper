//
//  Overlay.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import UIKit

class Overlay: View {
    
    enum RelativeTo {
        case superview
        case window
    }
    
    private var relativeTo: Overlay.RelativeTo = .window
    private var bringToFront: [UIView] = []
    private var opacity: CGFloat = 1.0
    
    private var blur: Blur?
    private var _isShow = false
    private var alreadyApplied = false
    private var zPosition: CGFloat = 9000
    
    private let component: UIView
    
    init(component: UIView) {
        self.component = component
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        
    }

    
//  MARK: - SET Attributes
    
    @discardableResult
    func setColor(_ color: UIColor) -> Self {
        self.setBackgroundColor(color)
        return self
    }
    
    @discardableResult
    func setOpacity(_ opacity: CGFloat) -> Self {
        self.opacity = opacity
        return self
    }
    
    @discardableResult
    func setOverlayRelative(to relativeTo: Overlay.RelativeTo) -> Self {
        self.relativeTo = relativeTo
        return self
    }
    
    @discardableResult
    func setBringToFront(_ components: [UIView]) -> Self {
        self.bringToFront = components
        return self
    }
    
    
//  MARK: - SHOW Overlay
    var isShow: Bool {
        get { return self._isShow}
        set {
            self._isShow = newValue
            applyOnceConfig()
            setIsHiddenOverlay()
        }
    }
    
    
//  MARK: - Private Function Area
    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            self.configOverlay()
            self.alreadyApplied = true
        }
    }
    
    private func setIsHiddenOverlay() {
        self.isHidden = !_isShow
        self.isUserInteractionEnabled = !_isShow
    }
    
    private func configOverlay() {
        setOverlayHierarchyPosition()
        createBlur()
        addOverlay()
        configOverlayConstraints()
        componentBringToFront()
    }
    
    private func componentBringToFront() {
        guard let window = CurrentWindow.get else {return}
//        window.bringSubviewToFront(component)
    }
    
    private func createBlur() {
        self.blur = Blur(self)
            .setStyle(.dark)
            .setOpacity(self.opacity)
            .apply()
    }
    
    private func addOverlay() {
        guard let superview = self.component.superview else {return}
        guard let window = CurrentWindow.get else {return}
        self.add(insideTo: superview)
    }
    
    private func configOverlayConstraints(){
        switch self.relativeTo {
            case .superview:
                guard let superview = self.component.superview else {return}
                makeOverlayConstraints(superview)
            
            case .window:
                guard let window = CurrentWindow.get else {return}
                makeOverlayConstraints(window)
        }
        
    }
    
    private func makeOverlayConstraints(_ view: UIView) {
        self.makeConstraints { make in
            make.setPin.equalTo(view)
        }
    }
 
    
    private func setOverlayHierarchyPosition() {
        self.layer.zPosition = zPosition
    }
    
}
