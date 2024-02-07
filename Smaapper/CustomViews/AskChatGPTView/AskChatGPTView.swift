//
//  AskChatGPTView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 29/05/23.
//

import UIKit


class AskChatGPTView: ViewBuilder {
    
    
    override init() {
        super.init()
        self.initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
        applyNeumorphism()
    }
    
    lazy var askChatGPTLabel: LabelBuilder = {
        return LabelBuilder("Ask ChatGPT")
            .setColor(Theme.shared.currentTheme.onSurface)
            .setFont(UIFont.systemFont(ofSize: 18, weight: .thin))
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(15)
                    .setLeading.equalToSuperView(23)
            }
    }()
    
    lazy var underLineView: ViewBuilder = {
        return ViewBuilder()
            .setGradient({ build in
                build
                    .setGradientColors(Theme.shared.currentTheme.primaryGradient)
                    .setAxialGradient(.leftToRight)
                    .apply()
            })
            .setBorder({ build in
                build.setCornerRadius(2)
            })
            .setShadow({ build in
                build
                    .setOffset(width: 3, height: 3)
                    .setColor(.black.withAlphaComponent(0.8))
                    .setOpacity(1)
                    .setRadius(3)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(askChatGPTLabel.view, .bottom, 4)
                    .setLeading.equalTo(askChatGPTLabel.view, .leading, -2)
                    .setHeight.equalToConstant(2)
                    .setWidth.equalToConstant(65)
            }
    }()
        
    lazy var chatGPTTextField: TextFieldClearableBuilder = {
        return TextFieldClearableBuilder("type here...")
            .setPadding(15)
            .setPlaceHolderColor(Theme.shared.currentTheme.onSurfaceVariant.withAlphaComponent(0.5))
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setTextColor(Theme.shared.currentTheme.onSurface)
            .setFont(UIFont.systemFont(ofSize: 17))
            .setBorder { build in
                build
                    .setCornerRadius(10)
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(underLineView.view, .bottom , 17)
                    .setLeading.equalToSuperView(15)
                    .setTrailing.equalToSuperView(-20)
                    .setHeight.equalToConstant(45)
            }
    }()    
    
    lazy var goChatGPTIconButton: IconButtonBuilder = {
        return IconButtonBuilder(UIImageView(image: UIImage(systemName: "arrow.up.right")))
            .setImageSize(12)
            .setImageColor(Theme.shared.currentTheme.onPrimary )
            .setImageWeight(.bold)
            .setGradient { build in
                build
                    .setGradientColors(Theme.shared.currentTheme.primaryGradient)
                    .setAxialGradient(.leftToRight)
                    .apply()
            }
            .setShadow { build in
                build
                    .setColor(.black)
                    .setRadius(5)
                    .setOpacity(1)
                    .setOffset(width: 3, height: 3)
                    .apply()
            }
            .setBorder({ build in
                build
                    .setCornerRadius(5)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(chatGPTTextField.view, .bottom, 12)
                    .setTrailing.equalTo(chatGPTTextField.view, .trailing, -3)
                    .setWidth.equalToConstant(35)
                    .setHeight.equalToConstant(28)
            }
    }()

    
//  MARK: - Private Area
    
    private func addElements() {
        underLineView.add(insideTo: self.view)
        askChatGPTLabel.add(insideTo: self.view)
        self.chatGPTTextField.add(insideTo: self.view)
        goChatGPTIconButton.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        underLineView.applyConstraint()
        askChatGPTLabel.applyConstraint()
        self.chatGPTTextField.applyConstraint()
        self.goChatGPTIconButton.applyConstraint()
        
    }
    
    private func applyNeumorphism() {
        DispatchQueue.main.async { [weak self] in
            self?.chatGPTTextField.setNeumorphism({ build in
                build.setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 100)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark , percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .setDistance(to: .dark, percent: 5)
                    .apply()
            })
        }
    }
    
    
}
