//
//  CalculatorButtonPanelViewDelegate.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/06/23.
//

import UIKit

protocol CalculatorButtonPanelViewDelegate: AnyObject {
    func calculatorButton(_ button: CalculatorButtonPanelView.CalculatorButtons )
}

class CalculatorButtonPanelView: ViewBuilder {
    
    weak var delegate: CalculatorButtonPanelViewDelegate?
    
    private let spacingVertical: CGFloat = 5
    private let spacingHorizontal: CGFloat = 10
    private let sizeButtons = CGSize(width: 43, height: 43)
    
    enum CalculatorButtons {
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
    
    lazy var horizontalStack1: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack2: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack3: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack4: StackBuilder = {
        let stack = StackBuilder()
            .setAxis(.horizontal)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack5: StackBuilder = {
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

    lazy var number0: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "0")
        btn.button.setActions { build in
            build.setTarget(self, #selector(zeroTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number1: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "1")
        btn.button.setActions { build in
            build.setTarget(self, #selector(oneTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number2: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "2")
        btn.button.setActions { build in
            build.setTarget(self, #selector(twoTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number3: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "3")
        btn.button.setActions { build in
            build.setTarget(self, #selector(threeTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number4: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "4")
        btn.button.setActions { build in
            build.setTarget(self, #selector(fourTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number5: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "5")
        btn.button.setActions { build in
            build.setTarget(self, #selector(fiveTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number6: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "6")
        btn.button.setActions { build in
            build.setTarget(self, #selector(sixTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number7: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "7")
        btn.button.setActions { build in
            build.setTarget(self, #selector(sevenTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number8: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "8")
        btn.button.setActions { build in
            build.setTarget(self, #selector(eightTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var number9: DefaultFloatViewButton = {
        let btn = createButtonLogiView(Theme.shared.currentTheme.surfaceContainer, "9")
        btn.button.setActions { build in
            build.setTarget(self, #selector(nineTapped), .touchUpInside)
        }
        return btn
    }()
    
    
//  MARK: - OPERATATION Area
    
    lazy var addition: DefaultFloatViewButton = {
        let img = UIImageView(image: UIImage(systemName: "plus"))
        let btn = createOperationsButtonLogiView(Theme.shared.currentTheme.secondary, img)
        btn.button.setActions { build in
            build.setTarget(self, #selector(additionTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var subtraction: DefaultFloatViewButton = {
        let img = UIImageView(image: UIImage(systemName: "minus"))
        let btn = createOperationsButtonLogiView(Theme.shared.currentTheme.secondary, img)
        btn.button.setActions { build in
            build.setTarget(self, #selector(subtractionTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var multiplication: DefaultFloatViewButton = {
        let img = UIImageView(image: UIImage(systemName: "multiply"))
        let btn = createOperationsButtonLogiView(Theme.shared.currentTheme.secondary, img)
        btn.button.setActions { build in
            build.setTarget(self, #selector(multiplicationTapped), .touchUpInside)
        }
        return btn
    }()
    
    lazy var division: DefaultFloatViewButton = {
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
                    .setCornerRadius(sizeButtons.height/2)
            })
            .setTitleSize(27)
            .setTitleColor(Theme.shared.currentTheme.onSurface, .normal)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setHeight.equalToConstant(sizeButtons.height)
                    .setWidth.equalToConstant(sizeButtons.width)
            }
            .setBackgroundColorLayer(Theme.shared.currentTheme.surfaceContainer.adjustBrightness(-20))
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
                    .setCornerRadius(sizeButtons.height/2)
            })
            .setImageSize(13)
            .setImageWeight(.regular)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setHeight.equalToConstant(sizeButtons.height)
                    .setWidth.equalToConstant(sizeButtons.width)
            }
            .setBackgroundColorLayer(Theme.shared.currentTheme.surfaceContainer)
            .setActions { build in
                build.setTarget(self, #selector(backspaceTapped), .touchUpInside)
            }
        return btn
    }()
    
    
//  MARK: - @OBJC Area
    
    @objc private func oneTapped() {
        delegate?.calculatorButton(.one)
        TappedButtonView(number1.outlineView.view).tapped
    }

    @objc private func twoTapped() {
        delegate?.calculatorButton(.two)
        TappedButtonView(number2.outlineView.view).tapped
    }
    
    @objc private func threeTapped() {
        delegate?.calculatorButton(.three)
        TappedButtonView(number3.outlineView.view).tapped
    }

    @objc private func fourTapped() {
        delegate?.calculatorButton(.four)
        TappedButtonView(number4.outlineView.view).tapped
    }

    @objc private func fiveTapped() {
        delegate?.calculatorButton(.five)
        TappedButtonView(number5.outlineView.view).tapped
    }

    @objc private func sixTapped() {
        delegate?.calculatorButton(.six)
        TappedButtonView(number6.outlineView.view).tapped
    }

    @objc private func sevenTapped() {
        delegate?.calculatorButton(.seven)
        TappedButtonView(number7.outlineView.view).tapped
    }

    @objc private func eightTapped() {
        delegate?.calculatorButton(.eight)
        TappedButtonView(number8.outlineView.view).tapped
    }

    @objc private func nineTapped() {
        delegate?.calculatorButton(.nine)
        TappedButtonView(number9.outlineView.view).tapped
    }

    @objc private func zeroTapped() {
        delegate?.calculatorButton(.zero)
        TappedButtonView(number0.outlineView.view).tapped
    }

    @objc private func additionTapped() {
        delegate?.calculatorButton(.addition)
        TappedButtonView(addition.outlineView.view).tapped
    }

    @objc private func subtractionTapped() {
        delegate?.calculatorButton(.subtraction)
        TappedButtonView(subtraction.outlineView.view).tapped
    }

    @objc private func multiplicationTapped() {
        delegate?.calculatorButton(.multiplication)
        TappedButtonView(multiplication.outlineView.view).tapped
    }

    @objc private func divisionTapped() {
        delegate?.calculatorButton(.division)
        TappedButtonView(division.outlineView.view).tapped
    }

    @objc private func equalsTapped() {
        delegate?.calculatorButton(.equals)
        TappedButtonView(equals.view).tapped
    }

    @objc private func clearTapped() {
        delegate?.calculatorButton(.clear)
        TappedButtonView(clear.view).tapped
    }

    @objc private func plusMinusTapped() {
        delegate?.calculatorButton(.plusMinus)
        TappedButtonView(plusMinus.view).tapped
    }

    @objc private func percentageTapped() {
        delegate?.calculatorButton(.percentage)
        TappedButtonView(percentage.view).tapped
    }

    @objc private func decimalSeparatorTapped() {
        delegate?.calculatorButton(.decimalSeparator)
        TappedButtonView(decimalSeparator.view).tapped
    }

    @objc private func backspaceTapped() {
        delegate?.calculatorButton(.backspace)
        TappedButtonView(backspace.view).tapped
    }


//  MARK: - PRIVATE Area

    private func createButtonLogiView(_ color: UIColor, _ text: String) -> DefaultFloatViewButton {
        let btnView = DefaultFloatViewButton(color, text)
        configButtonLogiView(btnView)
        return btnView
    }
    
    private func createOperationsButtonLogiView(_ color: UIColor, _ image: UIImageView) -> DefaultFloatViewButton {
        let btnView = DefaultFloatViewButton(color, image)
        configButtonLogiView(btnView)
        btnView.button.setImageWeight(.bold)
        return btnView
    }
    
    private func createAuxiliaryButtonLogiView(_ image: UIImageView) -> DefaultFloatViewButton {
        let btnView = DefaultFloatViewButton(Theme.shared.currentTheme.surfaceContainerHighest, image)
        configButtonLogiView(btnView)
        return btnView
    }

    private func createAuxiliaryButtonLogiView(_ text: String) -> DefaultFloatViewButton {
        let btnView = DefaultFloatViewButton(Theme.shared.currentTheme.surfaceContainerHighest, text)
        configButtonLogiView(btnView)
        return btnView
    }

    private func configButtonLogiView(_ btnView: DefaultFloatViewButton) {
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
        horizontalStack5.add(insideTo: stackVertical.view)
        horizontalStack4.add(insideTo: stackVertical.view)
        horizontalStack3.add(insideTo: stackVertical.view)
        horizontalStack2.add(insideTo: stackVertical.view)
        horizontalStack1.add(insideTo: stackVertical.view)
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
        addViewsToHorizontalStack5()
        addViewsToHorizontalStack4()
        addViewsToHorizontalStack3()
        addViewsToHorizontalStack2()
        addViewsToHorizontalStack1()
    }

    private func addViewsToHorizontalStack5() {
        viewAC.add(insideTo: horizontalStack5.view)
        viewPlusMinus.add(insideTo: horizontalStack5.view)
        viewPercentage.add(insideTo: horizontalStack5.view)
        viewDivision.add(insideTo: horizontalStack5.view)
    }
    
    private func addViewsToHorizontalStack4() {
        view7.add(insideTo: horizontalStack4.view)
        view8.add(insideTo: horizontalStack4.view)
        view9.add(insideTo: horizontalStack4.view)
        viewMultiplication.add(insideTo: horizontalStack4.view)
    }
    
    private func addViewsToHorizontalStack3() {
        view4.add(insideTo: horizontalStack3.view)
        view5.add(insideTo: horizontalStack3.view)
        view6.add(insideTo: horizontalStack3.view)
        viewSubtraction.add(insideTo: horizontalStack3.view)
    }
    
    private func addViewsToHorizontalStack2() {
        view1.add(insideTo: horizontalStack2.view)
        view2.add(insideTo: horizontalStack2.view)
        view3.add(insideTo: horizontalStack2.view)
        viewAddition.add(insideTo: horizontalStack2.view)
    }
    
    private func addViewsToHorizontalStack1() {
        viewDecimalSeparator.add(insideTo: horizontalStack1.view)
        view0.add(insideTo: horizontalStack1.view)
        viewBackspace.add(insideTo: horizontalStack1.view)
        viewEquals.add(insideTo: horizontalStack1.view)
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
