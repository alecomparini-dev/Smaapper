//
//  CalculatorButtonsView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/06/23.
//

import UIKit

protocol CalculatorButtonsViewDelegate: AnyObject {
    func calculatorButton(_ button: CalculatorButtonsView.CalculatorButtons )
}

class CalculatorButtonsView: ViewBuilder {
    
    weak var delegate: CalculatorButtonsViewDelegate?
    
    private let spacingVertical: CGFloat = 5
    private let spacingHorizontal: CGFloat = 10
    private let sizeButtons = CGSize(width: 43, height: 43)
    
    enum  CalculatorButtons {
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case zero
        case addition
        case subtraction
        case multiplication
        case division
        case equals
        case clear
        case plusMinus
        case percentage
        case decimalSeparator
        case backspace
    }
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        addElements()
        configConstraints()
    }
    
    
//  MARK: - STACK Area

    lazy var stackVertical: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.vertical)
            .setSpacing(spacingVertical)
            .setDistribution(.fillEqually)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return stack
    }()
    
    lazy var stackHorizontal1: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var stackHorizontal2: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var stackHorizontal3: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var stackHorizontal4: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var stackHorizontal5: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()


//  MARK: - VIEW Area

    lazy var view0: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var view1: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var view2: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var view3: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var view4: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var view5: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var view6: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var view7: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var view8: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var view9: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewAddition: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewSubtraction: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewMultiplication: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewDivision: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewEquals: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewBackspace: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewDecimalSeparator: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewPlusMinus: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewAC: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    lazy var viewPercentage: ViewBuilder = {
        let view = ViewBuilder()
        return view
    }()
    
    
//  MARK: - NUMBERS Area

    lazy var number0: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "0")
        btn.button.setActions { build in
            build.setTarget(self, #selector(zeroTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number1: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "1")
        btn.button.setActions { build in
            build.setTarget(self, #selector(oneTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number2: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "2")
        btn.button.setActions { build in
            build.setTarget(self, #selector(twoTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number3: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "3")
        btn.button.setActions { build in
            build.setTarget(self, #selector(threeTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number4: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "4")
        btn.button.setActions { build in
            build.setTarget(self, #selector(fourTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number5: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "5")
        btn.button.setActions { build in
            build.setTarget(self, #selector(fiveTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number6: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "6")
        btn.button.setActions { build in
            build.setTarget(self, #selector(sixTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number7: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "7")
        btn.button.setActions { build in
            build.setTarget(self, #selector(sevenTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number8: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "8")
        btn.button.setActions { build in
            build.setTarget(self, #selector(eightTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number9: ButtonLogiView = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "9")
        btn.button.setActions { build in
            build.setTarget(self, #selector(nineTapped), .touchUpInside)
        }
        return btn
    }()
    
    
//  MARK: - OPERATATION Area
    
    lazy var addition: ButtonLogiView = {
        let img = UIImageView(image: UIImage(systemName: "plus"))
        let btn = createOperationsButtonLogiView(Theme.shared.currentTheme.secondary, img)
        btn.button.setActions { build in
            build.setTarget(self, #selector(additionTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var subtraction: ButtonLogiView = {
        let img = UIImageView(image: UIImage(systemName: "minus"))
        let btn = createOperationsButtonLogiView(Theme.shared.currentTheme.secondary, img)
        btn.button.setActions { build in
            build.setTarget(self, #selector(subtractionTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var multiplication: ButtonLogiView = {
        let img = UIImageView(image: UIImage(systemName: "multiply"))
        let btn = createOperationsButtonLogiView(Theme.shared.currentTheme.secondary, img)
        btn.button.setActions { build in
            build.setTarget(self, #selector(multiplicationTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var division: ButtonLogiView = {
        let img = UIImageView(image: UIImage(systemName: "divide"))
        let btn = createOperationsButtonLogiView(Theme.shared.currentTheme.secondary, img)
        btn.button.setActions { build in
            build.setTarget(self, #selector(divisionTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var equals: ButtonImageBuilder = {
        let img = UIImageView(image: UIImage(systemName: "equal"))
        let btn = ButtonImageBuilder(img)
            .setBorder({ build in
                build
                    .setCornerRadius(7)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.tertiary)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 80)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .apply()
            }
            .setImageSize(15)
            .setImageWeight(.regular)
            .setTintColor(Theme.shared.currentTheme.onPrimary)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setHeight.equalToConstant(sizeButtons.height)
                    .setWidth.equalToConstant(sizeButtons.width)
            }
            .setActions { build in
                build.setTarget(self, #selector(equalsTapped), .touchUpInside)
            }
        return btn
    }()
    
    
//  MARK: - AUXILIARY Buttons

    lazy var clear: ButtonBuilder = {
        let btn = ButtonBuilder("AC")
            .setGradient({ build in
                build
                    .setAxialGradient(.rightBottomToLeftTop)
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer, percentageGradient: -10)
                    .apply()
            })
            .setBorder({ build in
                build
                    .setCornerRadius(sizeButtons.height/2)
            })
            .setTitleSize(14)
            .setTitleAlignment(.center)
            .setTitleColor(Theme.shared.currentTheme.onSurface, .normal)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setHeight.equalToConstant(sizeButtons.height)
                    .setWidth.equalToConstant(sizeButtons.width)
            }
            .setActions { build in
                build.setTarget(self, #selector(clearTapped), .touchUpInside)
            }
        return btn
    }()
    
    lazy var plusMinus: ButtonImageBuilder = {
        let img = UIImageView(image: UIImage(systemName: "plus.forwardslash.minus"))
        let btn = ButtonImageBuilder(img)
            .setBorder({ build in
                build
                    .setCornerRadius(sizeButtons.height/2)
            })
            .setGradient({ build in
                build
                    .setAxialGradient(.rightBottomToLeftTop)
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer, percentageGradient: -10)
                    .apply()
            })
            .setImageSize(12)
            .setImageWeight(.regular)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setHeight.equalToConstant(sizeButtons.height)
                    .setWidth.equalToConstant(sizeButtons.width)
            }
            .setActions { build in
                build.setTarget(self, #selector(plusMinusTapped), .touchUpInside)
            }
        return btn
    }()
    
    lazy var percentage: ButtonImageBuilder = {
        let img = UIImageView(image: UIImage(systemName: "percent"))
        let btn = ButtonImageBuilder(img)
            .setBorder({ build in
                build
                    .setCornerRadius(sizeButtons.height/2)
            })
            .setGradient({ build in
                build
                    .setAxialGradient(.rightBottomToLeftTop)
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer, percentageGradient: -10)
                    .apply()
            })
            .setImageSize(12)
            .setImageWeight(.regular)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setHeight.equalToConstant(sizeButtons.height)
                    .setWidth.equalToConstant(sizeButtons.width)
            }
            .setActions { build in
                build.setTarget(self, #selector(percentageTapped), .touchUpInside)
            }
        return btn
    }()
    
    lazy var decimalSeparator: ButtonBuilder = {
        let btn = ButtonBuilder(",")
            .setBorder({ build in
                build
                    .setCornerRadius(7)
            })
            .setTitleSize(27)
            .setTitleColor(Theme.shared.currentTheme.onSurface, .normal)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setLeading.setTrailing.equalToSuperView
                    .setTop.setBottom.equalToSuperView(2)
            }
            .setActions { build in
                build.setTarget(self, #selector(decimalSeparatorTapped), .touchUpInside)
            }
        return btn
    }()
    
    lazy var backspace: ButtonImageBuilder = {
        let img = UIImageView(image: UIImage(systemName: "delete.left"))
        let btn = ButtonImageBuilder(img)
            .setBorder({ build in
                build
                    .setCornerRadius(7)
                    .setWidth(0)
                    .setColor(Theme.shared.currentTheme.surfaceContainerHighest)
            })
            .setImageSize(16)
            .setImageWeight(.regular)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setLeading.setTrailing.equalToSuperView
                    .setTop.setBottom.equalToSafeArea(2)
            }
            .setActions { build in
                build.setTarget(self, #selector(backspaceTapped), .touchUpInside)
            }
        return btn
    }()
    
    
//  MARK: - @OBJC Area
    
    @objc private func oneTapped() {
        delegate?.calculatorButton(.one)
        number1.outlineView.setShadow { build in
            build
                .setColor(Theme.shared.currentTheme.primary.adjustBrightness(20))
                .setOffset(width: 0, height: 0)
                .setOpacity(0)
                .setRadius(2)
                .setBringToFront()
                .setID("activeButton")
                .apply()
        }
        
        let shadowLayer = number1.outlineView.shadow?.getShadowById("activeButton")
        if let shadowLayer {
            removeShadowOpacityAnimation(shadowLayer)
        }
        
    }

    @objc private func twoTapped() {
        delegate?.calculatorButton(.two)
        number2.outlineView.setShadow { build in
            build
                .setColor(Theme.shared.currentTheme.primary.adjustBrightness(20))
                .setOffset(width: 0, height: 0)
                .setOpacity(0)
                .setRadius(2)
                .setBringToFront()
                .setID("activeButton")
                .apply()
        }
        
        let shadowLayer = number2.outlineView.shadow?.getShadowById("activeButton")
        if let shadowLayer {
            removeShadowOpacityAnimation(shadowLayer)
        }

    }
    
    func animateShadowOpacity() {
//        let animation = CABasicAnimation(keyPath: "shadowOpacity")
//        animation.fromValue = 0.0
//        animation.toValue = 1.0
//        animation.duration = 1.0
//        let shadowLayer = number2.outlineView.shadow?.getShadowById("activeButton")
//        shadowLayer?.add(animation, forKey: "shadowOpacityAnimation")
//        shadowLayer?.shadowOpacity = 1.0
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.removeShadowOpacityAnimation()
//        }
        
    }

    func removeShadowOpacityAnimation(_ shadowLayer: CALayer) {
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = 1.0
        animation.toValue = 1.0
        animation.duration = 0.2
        shadowLayer.add(animation, forKey: "shadowOpacityAnimation")
        shadowLayer.shadowOpacity = 0.0
        
//        let shadowLayer = number2.outlineView.shadow?.getShadowById("activeButton")
//        shadowLayer?.removeAnimation(forKey: "shadowOpacityAnimation")
//        shadowLayer?.shadowOpacity = 0.0
    }
    

    @objc private func threeTapped() {
        delegate?.calculatorButton(.three)
        number3.outlineView.setShadow { build in
            build
                .setColor(Theme.shared.currentTheme.primary.adjustBrightness(20))
                .setOffset(width: 0, height: 0)
                .setOpacity(0)
                .setRadius(2)
                .setBringToFront()
                .setID("activeButton")
                .apply()
        }
        
        let shadowLayer = number3.outlineView.shadow?.getShadowById("activeButton")
        if let shadowLayer {
            removeShadowOpacityAnimation(shadowLayer)
        }
    }

    @objc private func fourTapped() {
        delegate?.calculatorButton(.four)
        
    }

    @objc private func fiveTapped() {
        delegate?.calculatorButton(.five)
    }

    @objc private func sixTapped() {
        delegate?.calculatorButton(.zero)
    }

    @objc private func sevenTapped() {
        delegate?.calculatorButton(.seven)
    }

    @objc private func eightTapped() {
        delegate?.calculatorButton(.eight)
    }

    @objc private func nineTapped() {
        delegate?.calculatorButton(.nine)
    }

    @objc private func zeroTapped() {
        delegate?.calculatorButton(.zero)
    }

    @objc private func additionTapped() {
        delegate?.calculatorButton(.addition)
    }

    @objc private func subtractionTapped() {
        delegate?.calculatorButton(.subtraction)
    }

    @objc private func multiplicationTapped() {
        delegate?.calculatorButton(.multiplication)
    }

    @objc private func divisionTapped() {
        delegate?.calculatorButton(.division)
    }

    @objc private func equalsTapped() {
        delegate?.calculatorButton(.equals)
    }

    @objc private func clearTapped() {
        delegate?.calculatorButton(.clear)
    }

    @objc private func plusMinusTapped() {
        delegate?.calculatorButton(.plusMinus)
    }

    @objc private func percentageTapped() {
        delegate?.calculatorButton(.percentage)
    }

    @objc private func decimalSeparatorTapped() {
        delegate?.calculatorButton(.decimalSeparator)
    }

    @objc private func backspaceTapped() {
        delegate?.calculatorButton(.backspace)
    }


//  MARK: - PRIVATE Area

    private func createButtonLogiView(_ color: UIColor, _ text: String) -> ButtonLogiView {
        let btnView = ButtonLogiView(color, text)
        configButtonLogiView(btnView)
        return btnView
    }
    
    private func createOperationsButtonLogiView(_ color: UIColor, _ image: UIImageView) -> ButtonLogiView {
        let btnView = ButtonLogiView(color, image)
        configButtonLogiView(btnView)
        btnView.button.setImageWeight(.bold)
        return btnView
    }
    
    private func createAuxiliaryButtonLogiView(_ image: UIImageView) -> ButtonLogiView {
        let btnView = ButtonLogiView(Theme.shared.currentTheme.surfaceContainerHighest, image)
        configButtonLogiView(btnView)
        return btnView
    }

    private func createAuxiliaryButtonLogiView(_ text: String) -> ButtonLogiView {
        let btnView = ButtonLogiView(Theme.shared.currentTheme.surfaceContainerHighest, text)
        configButtonLogiView(btnView)
        return btnView
    }

    private func configButtonLogiView(_ btnView: ButtonLogiView) {
        btnView.configCornerRadiusInnerview(sizeButtons.height/2)
        btnView.setConstraints { build in
            build
                .setAlignmentCenterXY.equalToSuperView
                .setWidth.equalToConstant(sizeButtons.width)
                .setHeight.equalToConstant(sizeButtons.height)
        }
    }

    private func addElements() {
        addStacks()
        addElementsToViews()
        addViewsToStacks()
    }

    private func configConstraints() {
        stackVertical.applyConstraint()
        configNumbersConstraints()
        configOperationsConstraints()
        configAuxiliaryConstraints()
    }

    private func addStacks() {
        stackVertical.add(insideTo: self.view)
        stackHorizontal5.add(insideTo: stackVertical.view)
        stackHorizontal4.add(insideTo: stackVertical.view)
        stackHorizontal3.add(insideTo: stackVertical.view)
        stackHorizontal2.add(insideTo: stackVertical.view)
        stackHorizontal1.add(insideTo: stackVertical.view)
    }

    private func addElementsToViews() {
        addNumbersToViews()
        addOperationsToViews()
        addAuxiliaryButtonsToViews()
    }
    
    private func addNumbersToViews() {
        number0.add(insideTo: view0.view)
        number1.add(insideTo: view1.view)
        number2.add(insideTo: view2.view)
        number3.add(insideTo: view3.view)
        number4.add(insideTo: view4.view)
        number5.add(insideTo: view5.view)
        number6.add(insideTo: view6.view)
        number7.add(insideTo: view7.view)
        number8.add(insideTo: view8.view)
        number9.add(insideTo: view9.view)
    }
    
    private func addOperationsToViews() {
        addition.add(insideTo: viewAddition.view)
        subtraction.add(insideTo: viewSubtraction.view)
        division.add(insideTo: viewDivision.view)
        multiplication.add(insideTo: viewMultiplication.view)
        equals.add(insideTo: viewEquals.view)
    }
    
    private func addAuxiliaryButtonsToViews() {
        percentage.add(insideTo: viewPercentage.view)
        backspace.add(insideTo: viewBackspace.view)
        decimalSeparator.add(insideTo: viewDecimalSeparator.view)
        clear.add(insideTo: viewAC.view)
        plusMinus.add(insideTo: viewPlusMinus.view)
    }
    
    private func addViewsToStacks() {
        addViewsToStackHorizontal5()
        addViewsToStackHorizontal4()
        addViewsToStackHorizontal3()
        addViewsToStackHorizontal2()
        addViewsToStackHorizontal1()
    }

    private func addViewsToStackHorizontal5() {
        viewAC.add(insideTo: stackHorizontal5.view)
        viewPlusMinus.add(insideTo: stackHorizontal5.view)
        viewPercentage.add(insideTo: stackHorizontal5.view)
        viewDivision.add(insideTo: stackHorizontal5.view)
    }
    
    private func addViewsToStackHorizontal4() {
        view7.add(insideTo: stackHorizontal4.view)
        view8.add(insideTo: stackHorizontal4.view)
        view9.add(insideTo: stackHorizontal4.view)
        viewMultiplication.add(insideTo: stackHorizontal4.view)
    }
    
    private func addViewsToStackHorizontal3() {
        view4.add(insideTo: stackHorizontal3.view)
        view5.add(insideTo: stackHorizontal3.view)
        view6.add(insideTo: stackHorizontal3.view)
        viewSubtraction.add(insideTo: stackHorizontal3.view)
    }
    
    private func addViewsToStackHorizontal2() {
        view1.add(insideTo: stackHorizontal2.view)
        view2.add(insideTo: stackHorizontal2.view)
        view3.add(insideTo: stackHorizontal2.view)
        viewAddition.add(insideTo: stackHorizontal2.view)
    }
    
    private func addViewsToStackHorizontal1() {
        viewDecimalSeparator.add(insideTo: stackHorizontal1.view)
        view0.add(insideTo: stackHorizontal1.view)
        viewBackspace.add(insideTo: stackHorizontal1.view)
        viewEquals.add(insideTo: stackHorizontal1.view)
    }
    
    private func configNumbersConstraints() {
        number0.applyConstraint()
        number1.applyConstraint()
        number2.applyConstraint()
        number3.applyConstraint()
        number4.applyConstraint()
        number5.applyConstraint()
        number6.applyConstraint()
        number7.applyConstraint()
        number8.applyConstraint()
        number9.applyConstraint()
    }
    
    private func configOperationsConstraints() {
        addition.applyConstraint()
        subtraction.applyConstraint()
        division.applyConstraint()
        multiplication.applyConstraint()
        equals.applyConstraint()
    }
    
    private func configAuxiliaryConstraints() {
        percentage.applyConstraint()
        backspace.applyConstraint()
        decimalSeparator.applyConstraint()
        clear.applyConstraint()
        plusMinus.applyConstraint()
    }
    
}
