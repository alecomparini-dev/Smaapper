//
//  TitleWindow.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 19/05/23.
//

import UIKit


internal class TitleFloatView: View {
    
    private var _isShow = false
    private var alreadyApplied = false
    
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
    }
    
    
//  MARK: - Lazy Properties
    
    lazy private var titleView: ViewBuilder = {
        let view = ViewBuilder()
            .setConstraints { build in
                build.setPin.equalToSuperView
            }
        return view
    }()
    
    
//  MARK: - SET Properties
    @discardableResult
    func setTitleView(_ view: UIView) -> Self {
        addTitleView(view)
        return self
    }
    
    
//  MARK: - SHOW title
    var isShow: Bool {
        get { return _isShow }
        set {
            _isShow = newValue
            applyOnceConfig()
            self.isHidden = !self._isShow
        }
    }
    
//  MARK: - Private Function Area
    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            configLayer()
        }
    }
    
    private func configLayer() {
        self.makeBorder { make in
            make
                .setCornerRadius((self.superview?.layer.cornerRadius ?? 0)/2)
                .setWhichCornersWillBeRounded([.top])
        }
    }
 
    private func addElements() {
        titleView.add(insideTo: self)
    }
    
    private func configConstraint() {
        titleView.applyConstraint()
    }
    
    
    private func addTitleView(_ view: UIView) {
        view.add(insideTo: titleView.view)
        view.makeConstraints { make in
            make.setPin.equalToSuperView
        }
    }
    
  
    
}
