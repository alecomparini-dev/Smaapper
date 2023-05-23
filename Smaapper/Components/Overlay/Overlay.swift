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
    
    private var _isShow = false
    private var alreadyApplied = false
    
    private var relativeTo: Overlay.RelativeTo = .window
    private var color: UIColor?
    private var opacity: CGFloat = 1
    
    private let component: UIView
    
    init(component: UIView) {
        self.component = component
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SET Properties

    @discardableResult
    func setColor(_ color: UIColor) -> Self {
        self.setBackgroundColor(color)
        return self
    }
    
    @discardableResult
    func setOpacity(_ opacity: CGFloat) -> Self {
        self.alpha = opacity
        return self
    }
    
    @discardableResult
    func setOverlayRelative(to relativeTo: Overlay.RelativeTo) -> Self {
        self.relativeTo = relativeTo
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
            DispatchQueue.main.async {
                self.configOverlay()
                self.alreadyApplied = true
            }
        }
    }
    
    private func setIsHiddenOverlay() {
        self.isHidden = !_isShow
        self.isUserInteractionEnabled = _isShow
    }
    
    private func configOverlay() {
        switch self.relativeTo {
        case .superview:
            configOverlaySuperView()
        case .window:
            configOverlayWindow()
        }
    }
    
    
    private func configOverlaySuperView() {
        guard let superview = self.component.superview else {return}
        addOverlay(insideTo: superview)
    }
    
    private func configOverlayWindow() {
        guard let window = CurrentWindow.get else {return}
        addOverlay(insideTo: window)
        configOverlayConstraints()
    }
    
    private func addOverlay(insideTo view: UIView) {
        self.add(insideTo: view)
        
    }
    
    private func configOverlayConstraints(){
        self.makeConstraints { make in
            make.setPin.equalToSuperView
        }
        
    }
    
}
