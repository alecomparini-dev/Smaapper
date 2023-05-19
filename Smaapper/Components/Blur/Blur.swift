//
//  Blur.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 18/05/23.
//

import UIKit

class Blur {
    
    private var blurView: UIVisualEffectView?
    private var blurEffect: UIBlurEffect?
    private var vibrancyView: UIVisualEffectView?
    
    private var vibrancyEnabled = true
    private var component: UIView
    
    init(_ component: UIView) {
        self.component = component
    }
    
//  MARK: - SET Properties
    @discardableResult
    func setStyle(_ style: UIBlurEffect.Style) -> Self {
        self.blurEffect = UIBlurEffect(style: style)
        return self
    }
    
//    @discardableResult
//    func setVibrancyEnabled(_ flag: Bool) -> Self {
//        self.vibrancyEnabled = flag
//        return self
//    }
    
    
//  MARK: - Apply Gradient
    @discardableResult
    func apply() -> Self {
        configBlur()
        return self
    }
    
    
//  MARK: - Private Function Area
    
    private func configBlur() {
        configBackgroundColor()
        configBlurView()
        blurView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if vibrancyEnabled {
            configVibrancyView()
        }
    }
    
    private func configBackgroundColor() {
        component.backgroundColor = .clear
    }
    
    
//  MARK: - BLUR AREA

    private func configBlurView() {
        createBlurView()
        addBlurOnComponent()
        configConstraintsBlurView()
        configAlphaBlur()
    }
    
    private func configAlphaBlur() {
        blurView?.alpha = 0.98
    }
    
    private func createBlurView() {
        self.blurView = UIVisualEffectView(effect: self.blurEffect)
    }
    
    private func addBlurOnComponent () {
        guard let blurView = self.blurView else { return }
        component.addSubview(blurView)
    }
    
    private func configConstraintsBlurView() {
        self.blurView?.makeConstraints({ make in
            make.setPin.equalTo(component)
        })
    }
    
    

//  MARK: - VIBRANCY AREA
    private func configVibrancyView() {
        createVibrancyView()
        addVibrancyView()
        configConstraintsVibrancyView()
    }
    
    private func createVibrancyView() {
        if let blurEffect {
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            self.vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        }
    }
    
    private func addVibrancyView() {
        if let vibrancyView {
            blurView?.contentView.addSubview(vibrancyView)
        }
    }
    
    private func configConstraintsVibrancyView() {
        guard let vibrancyView, let blurView else {return}
        vibrancyView.makeConstraints { make in
            make
                .setPin.equalTo(blurView)
        }
        
        
    }
    
    

    
}
