//
//  BlurBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 18/05/23.
//

import UIKit

class BlurBuilder {
    
    private var blurEffect: UIBlurEffect?
    private var blurVisualEffectView: UIVisualEffectView?
    private var vibrancyView: UIVisualEffectView?
    private var opacity: CGFloat = 0.98
    
    private var vibrancyEnabled = false
    private weak var component: UIView?
    
    init(_ component: UIView) {
        self.component = component
    }
    
//  MARK: - SET Properties
    @discardableResult
    func setStyle(_ style: UIBlurEffect.Style) -> Self {
        self.blurEffect = UIBlurEffect(style: style)
        return self
    }
    
    @discardableResult
    func setOpacity(_ opacity: CGFloat) -> Self {
        self.opacity = opacity
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
        createBlurVisualEffectView()
        addBlurOnComponent()
        configConstraintsBlurView()
        blurVisualEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        configAlphaBlur()
        
        if vibrancyEnabled {
            configVibrancyView()
        }
    }
    
    private func configBackgroundColor() {
        component?.backgroundColor = .clear
    }
    
    
//  MARK: - BLUR AREA

    private func configAlphaBlur() {
        blurVisualEffectView?.alpha = self.opacity
    }
    
    private func createBlurVisualEffectView() {
        self.blurVisualEffectView = UIVisualEffectView(effect: self.blurEffect)
    }
    
    private func addBlurOnComponent () {
        guard let blurView = self.blurVisualEffectView else { return }
        component?.addSubview(blurView)
    }
    
    private func configConstraintsBlurView() {
        self.blurVisualEffectView?.makeConstraints({ make in
            make
                .setPin.equalToSuperView
                .apply()
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
            blurVisualEffectView?.contentView.addSubview(vibrancyView)
        }
    }
    
    private func configConstraintsVibrancyView() {
        guard let vibrancyView, let blurVisualEffectView else {return}
        vibrancyView.makeConstraints { make in
            make
                .setPin.equalTo(blurVisualEffectView)
                .apply()
        }
        
        
    }
    
    

    
}
