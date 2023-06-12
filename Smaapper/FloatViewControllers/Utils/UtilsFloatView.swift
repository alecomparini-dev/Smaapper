//
//  UtilsFloatView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

class UtilsFloatView {

    static func configNeumorphisFloatView(_ view: ViewBuilder) {
        view.setNeumorphism { build in
            build
                .setReferenceColor(Theme.shared.currentTheme.surfaceContainerLow)
                .setShape(.concave)
                .setLightPosition(.leftTop)
                .setBlur(to: .light, percent: 5)
                .apply()
        }
    }

    
    static func setShadowActiveFloatView(_ view: ViewBuilder) {
        view.setShadow { build in
            build
                .setColor(Theme.shared.currentTheme.primary)
                .setOffset(width: 0, height: 0)
                .setOpacity(0.8)
                .setRadius(2)
                .setBringToFront()
                .setID("activeFloatView")
                .apply()
        }
    }
    
    static func removeShadowActiveFloatView(_ view: ViewBuilder) {
        view.view.removeShadowByID("activeFloatView")
    }
    
    static func titleFloatView(_ target: Any, _ actionMinimize: Selector, _ actionClose: Selector)  -> ViewBuilder {
        let view = ViewBuilder()
        
        let btnMin = minimizeWindowButton(target, actionMinimize)
        btnMin.add(insideTo: view.view)
        btnMin.applyConstraint()
    
        let btnClose = closeWindowButton(target, actionClose)
        btnClose.add(insideTo: view.view)
        btnClose.applyConstraint()

        return view
    }
    
    
    static private func minimizeWindowButton(_ target: Any, _ action: Selector) -> ButtonImageBuilder {
        let btn = ButtonImageBuilder(UIImageView(image: UIImage(systemName: "minus.square.fill")))
            .setImageSize(14)
            .setImageWeight(.semibold)
            .setTitleAlignment(.center)
            .setImageColor(Theme.shared.currentTheme.onSurfaceVariant.withAlphaComponent(0.8))
            .setConstraints { build in
                build
                    .setSize.equalToConstant(25)
                    .setTop.equalToSuperView(7)
                    .setTrailing.equalToSuperView(-7)
            }
            .setActions { build in
                build
                    .setTarget(target, action, .touchUpInside)
            }
        return btn
    }
    
    
    static private func closeWindowButton(_ target: Any, _ action: Selector) -> ButtonImageBuilder {
        let btn = ButtonImageBuilder(UIImageView(image: UIImage(systemName: "xmark")))
            .setImageSize(10)
            .setImageWeight(.semibold)
            .setTitleAlignment(.center)
            .setImageColor(Theme.shared.currentTheme.onSurfaceVariant.withAlphaComponent(0.5))
            .setConstraints { build in
                build
                    .setSize.equalToConstant(25)
                    .setTop.equalToSuperView(7)
                    .setLeading.equalToSuperView(8)
            }
            .setActions { build in
                build
                    .setTarget(target, action, .touchUpInside)
            }
        return btn
    }
    
    
}

