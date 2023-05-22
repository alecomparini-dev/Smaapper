//
//  ClockNeumorphism.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


class ClockNeumorphism: View {
    
    enum Weight {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black
    }
    
    private var timer: DispatchSourceTimer?
    private var weight: CGFloat = 3
    
    override init() {
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addElements()
        configConstraint()
        createClock()
    }
    
    lazy var stackHours: Stack = {
        let st = Stack()
            .setAxis(.horizontal)
            .setDistribution(.fillEqually)
            .setSpacing(8)
        return st
    }()
    
    lazy var stackMinutes: Stack = {
        let st = Stack()
            .setAxis(.horizontal)
            .setDistribution(.fillEqually)
            .setSpacing(8)
        return st
    }()
    
    
    lazy var twoPoints: View = {
        let view = View()
        
        let stack = Stack()
            .setAxis(.vertical)
            .setDistribution(.fillEqually)
    
        stack.add(insideTo: view)
        stack.makeConstraints { make in
            make.setPin.equalToSuperView
        }
        let topView = View()
        let middleView = View()
        let bottomView = View()
        
        topView.add(insideTo: stack)
        middleView.add(insideTo: stack)
        bottomView.add(insideTo: stack)
    
        DispatchQueue.main.async { 
            let points = self.createTwoPoints(middleView.frame.height)
            points.add(insideTo: middleView)
            points.makeConstraints { make in
                make.setPin.equalToSuperView
            }
        }
        return view
    }()
    
    
//  MARK: - SET Properties
    func setWeight(_ weight: CGFloat) -> Self {
        self.weight = weight
        return self
    }
    
    
//  MARK: - Private Function Area
    
    // TODO: - CREATE METHOD START OR SHOW AND UPDATE ONLY WHEN NUMBER CHANGES
    private func createClock() {
        updateClock()
        timer = DispatchSource.makeTimerSource()
        
        timer?.schedule(deadline: .now(), repeating: .seconds(1))
        timer?.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "ss"
                if dateFormatter.string(from: Date()) == "00" {
                    self?.updateClock()
                }
            }
        }
        timer?.resume()
    }
    
    private func updateClock() {
        removeSubviews()
        let hour1 = ClockNumbers(number: getHour(firstPosition: true), weight: weight)
        let hour2 = ClockNumbers(number: getHour(firstPosition: false), weight: weight)
        let minute1 = ClockNumbers(number: getMinute(firstPosition: true), weight: weight)
        let minute2 = ClockNumbers(number: getMinute(firstPosition: false), weight: weight)
        hour1.add(insideTo: stackHours)
        hour2.add(insideTo: stackHours)
        minute1.add(insideTo: stackMinutes)
        minute2.add(insideTo: stackMinutes)
    }
    
    private func removeSubviews() {
        stackHours.subviews.forEach { $0.removeFromSuperview() }
        stackMinutes.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func getHour(firstPosition: Bool) -> Int {
        let hour = getDateFormatter("HH")
        if firstPosition {
            return Int(hour.prefix(1)) ?? 0
        }
        return Int(hour.prefix(2).suffix(1)) ?? 0
    }
    
    private func getMinute(firstPosition: Bool) -> Int {
        let minutes = getDateFormatter("mm")
        if firstPosition {
            return Int(minutes.prefix(1)) ?? 0
        }
        return Int(minutes.prefix(2).suffix(1)) ?? 0
    }
    
    private func getDateFormatter(_ formatter: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        return dateFormatter.string(from: Date())
    }
    
    private func createTwoPoints(_ width: CGFloat) -> UIView {
        let widthPoints = width/3
        let point1 = createPoint(widthPoints)
        let point2 = createPoint(widthPoints)
        
        let view = UIView()
        point1.add(insideTo: view)
        point2.add(insideTo: view)
        
        point1.makeConstraints { make in
            make
                .setTop.equalToSuperView(-4)
                .setHorizontalAlignmentX.equalTo(view)
                .setSize.equalToConstant(widthPoints)
        }
        
        point2.makeConstraints { make in
            make
                .setBottom.equalToSuperView(4)
                .setHorizontalAlignmentX.equalToSuperView
                .setSize.equalToConstant(widthPoints)
        }
        
        return view
    }
    
    private func createPoint(_ widthPoints: CGFloat) -> View {
        return View()
            .setBorder { build in
                build.setCornerRadius(widthPoints/2)
            }
            .setNeumorphism { build in
                build
                    .setReferenceColor(UIColor.HEX("#f77c22"))
                    .setShape(.flat)
                    .setLightPosition(.leftTop)
                    .setShadowColor(to: .dark, .black)
                    .setIntensity(to:.light,percent: 0)
                    .setIntensity(to:.dark,percent: 100)
                    .setBlur(to:.light, percent: 0)
                    .setBlur(to:.dark, percent: 3)
                    .setDistance(to:.light, percent: 3)
                    .setDistance(to:.dark, percent: 10)
                    .apply()
            }
    }
    
    
    private func addElements() {
        stackHours.add(insideTo: self)
        stackMinutes.add(insideTo: self)
        twoPoints.add(insideTo: self)
        
    }
    
    private func configConstraint() {
        configStackHoursConstraint()
        configTwoPointsConstraint()
        configStackMinutesConstraint()
        
    }
    
    private func configStackHoursConstraint() {
        stackHours.makeConstraints { make in
            make
                .setPinLeft.equalToSuperView
                .setTrailing.equalTo(twoPoints, .leading, -3)
        }
    }
    
    private func configStackMinutesConstraint() {
        stackMinutes.makeConstraints { make in
            make
                .setPinRight.equalToSuperView
                .setLeading.equalTo(twoPoints, .trailing)
        }
    }
    
    private func configTwoPointsConstraint() {
        twoPoints.makeConstraints { make in
            make
                .setTop.setBottom.equalToSuperView
                .setWidth.equalToConstant(20)
                .setHorizontalAlignmentX.equalToSuperView
        }
    }
    
    
    
}
