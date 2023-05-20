//
//  ClockNumbers.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


class ClockNumbers: View {
    
    private let weight: CGFloat = 7
    private var neumorphism: Neumorphism?
    
    override init() {
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addElement()
        configConstraints()
    }
    
    lazy var stackLeft: Stack = {
        let st = Stack()
            .setAxis(.vertical)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setSpacing(4)
        return st
    }()
    
    lazy var stackMiddle: Stack = {
        let st = Stack()
            .setAxis(.vertical)
//            .setAlignment(.center)
            .setDistribution(.fillProportionally)
        return st
    }()
    
    lazy var stackRight: Stack = {
        let st = Stack()
            .setAxis(.vertical)
            .setAlignment(.fill)
            .setDistribution(.fillEqually)
            .setSpacing(4)
        return st
    }()
    
    lazy var leftTopStroke: View = {
        return createView(true)
    }()
    
    lazy var leftBottomStroke: View = {
        return createView(true)
    }()
    
    lazy var topStroke: View = {
        return createView(true)
    }()
    
    lazy var middleStroke: View = {
        return createView(true)
    }()
    
    
    lazy var bottomStroke: View = {
        return createView(true)
    }()
    

    
    
    lazy var middleTopView: View = {
        return createView(false)
    }()
    
    lazy var middleView: View = {
        return createView(false)
    }()
    
    lazy var middleBottomView: View = {
        return createView(false)
    }()
    
    
//  MARK: - Private Functions Area
    
    private func configNeumorphism(_ lightPosition: Neumorphism.LightPosition = .leftTop) -> Neumorphism {
        return Neumorphism()
            .setReferenceColor(UIColor.HEX("#26292a"))
            .setShape(.flat)
            .setLightPosition(lightPosition)
            .setIntensity(to:.light,percent: 50)
            .setIntensity(to:.dark,percent: 100)
            .setBlur(to:.light, percent: 3)
            .setBlur(to:.dark, percent: 5)
            .setDistance(to:.light, percent: 3)
            .setDistance(to:.dark, percent: 7)
    }
    
    private func addElement() {
        addStackLeft()
        addStackMiddle()
        addStackRight()
    }
    
    private func addStackLeft() {
        stackLeft.add(insideTo: self)
        leftTopStroke.add(insideTo: stackLeft)
        leftBottomStroke.add(insideTo: stackLeft)
    }

    private func addStackMiddle() {
        stackMiddle.add(insideTo: self)
        middleTopView.add(insideTo: stackMiddle)
        middleView.add(insideTo: stackMiddle)
        middleBottomView.add(insideTo: stackMiddle)
        
        topStroke.add(insideTo: middleTopView)
        middleStroke.add(insideTo: middleView)
        bottomStroke.add(insideTo: middleBottomView)
    }
    
    private func addStackRight(){
        stackRight.add(insideTo: self)
        createView(true).add(insideTo: stackRight)
        createView(true).add(insideTo: stackRight)
    }
    
    private func configConstraints() {
        configStackLeftConstraints()
        configStackMiddleConstraints()
        configStackRightConstraints()
        
        configTopStrokeConstraints()
        configMiddleStrockConstraints()
        configBottomStrokeConstraints()

    }
    
    private func configStackLeftConstraints() {
        stackLeft.makeConstraints({ make in
                make
                    .setTop.setBottom.equalToSuperView(1)
                    .setLeading.equalToSuperView
                    .setWidth.equalToConstant(weight)
            })
    }
    
    
    private func configStackMiddleConstraints() {
        stackMiddle.makeConstraints({ make in
                make
                    .setTop.setBottom.equalToSuperView
                    .setLeading.equalTo(stackLeft, .trailing, 0)
                    .setTrailing.equalTo(stackRight, .leading, 0)
            })
    }
    
    private func configStackRightConstraints() {
        stackRight.makeConstraints({ make in
                make
                    .setTop.setBottom.equalToSuperView(1)
                    .setTrailing.equalToSuperView
                    .setWidth.equalToConstant(weight)
            })
    }
    
    
    private func configTopStrokeConstraints() {
        topStroke.makeConstraints { make in
            make
                .setPinTop.equalToSuperView
                .setHeight.equalToConstant(weight/1.4)
        }
    }
    
    private func configMiddleStrockConstraints() {
        middleStroke.makeConstraints { make in
            make
                .setVerticalAlignmentY.equalToSafeArea
                .setLeading.setTrailing.equalToSuperView
                .setHeight.equalToConstant(weight/2)
        }
    }
    
    private func configBottomStrokeConstraints() {
        bottomStroke.makeConstraints { make in
            make
                .setPinBottom.equalToSuperView
                .setHeight.equalToConstant(weight/1.4)
        }
    }
    
    private func createView(_ withNeumorphism: Bool, _ lightPosition: Neumorphism.LightPosition = .leftTop) -> View {
        let v = View()
        if withNeumorphism {
            configNeumorphism(lightPosition).apply(v)
        }
        return v
    }
    
}
