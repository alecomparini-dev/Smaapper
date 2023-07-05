//
//  StickyNoteView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 03/07/23.
//

import UIKit

protocol StickyNoteViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
    func addButtonTapped()
}

class StickyNoteView: ViewBuilder {
    
    weak var delegate: StickyNoteViewDelegate?
    
    override init() {
        super.init()
        initialization()
    }
    
    private func initialization() {
        configStyles()
        addElements()
        configConstraints()
    }
    
    //  MARK: - LAZY Area
    lazy var titleView: ViewBuilder = {
        let view = TitleFloatView(logo: K.Sticky.Images.logo,
                                  title: K.Sticky.title,
                                  target: self,
                                  closeClosure: #selector(closeWindow),
                                  minimizeClosure: #selector(minimizeWindow))
            .setConstraints { build in
                build
                    .setPinTop.equalToSuperView(12)
                    .setHeight.equalToConstant(25)
            }
        return view
    }()
    
    lazy var cameraARKit: CameraARKitView = {
        let arKit = CameraARKitView()
            .setImageTarget(createImageTarget())
            .setAlignmentTarget(.middle, -35)
            .makeBorder { make in
                make
                    .setCornerRadius(20)
            }            
        return arKit
    }()
    
    lazy var overlay: ViewBuilder = {
        let view = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(20)
                    .setWhichCornersWillBeRounded([.bottom])
            })
            .setBlur { build in
                build
                    .setStyle(.dark)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setPinBottom.equalTo(cameraARKit)
                    .setHeight.equalToConstant(90)
            }
        return view
    }()
    
    lazy var descriptionLabel: LabelBuilder = {
        let label = LabelBuilder()
        return label
    }()
    
    lazy var inputTextField: TextFieldBuilder = {
        let tf = TextFieldBuilder("Enter your note")
            .setFont(UIFont.systemFont(ofSize: 15, weight: .regular))
            .setPlaceHolderColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setTextColor(Theme.shared.currentTheme.onSurface)
            .setPadding(10, .left)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setNeumorphism({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainerHighest)
                    .setShape(.concave)
                    .setIntensity(to: .light, percent: 80)
                    .setBlur(to: .light, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setLeading.equalToSuperView(15)
                    .setVerticalAlignmentY.equalToSuperView
                    .setTrailing.equalTo(addButton.view, .leading, -15)
                    .setHeight.equalToConstant(45)
            }
        return tf
    }()
    
    lazy var addButton: IconButtonBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "plus"))
        let tf = IconButtonBuilder(img.view)
            .setImageSize(18)
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setTitleSize(12)
            .setImagePadding(5)
            .setBorder({ build in
                build
                    .setCornerRadius(20)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.secondary)
                    .setShape(.concave)
                    .setIntensity(to: .light, percent: 70)
                    .setBlur(to: .light, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView
                    .setTrailing.equalToSuperView(-15)
                    .setWidth.setHeight.equalToConstant(40)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(addButtonTapped), .touchUpInside)
            }
        return tf
    }()
    
    
//  MARK: - OBJCT Area
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    @objc private func closeWindow() {
        delegate?.closeWindow()
    }
    
    @objc private func addButtonTapped() {
        delegate?.addButtonTapped()
    }
    
//  MARK: - PRIVATE Area
    private func configStyles() {
        configBorder()
        configNeumorphism()
    }
    
    private func configBorder() {
        self.setBorder { build in
            build
                .setCornerRadius(20)
        }
    }
    
    private func configNeumorphism() {
        UtilsFloatView.configNeumorphisFloatView(self)
    }
    
    private func addElements() {
        titleView.add(insideTo: self.view)
        cameraARKit.add(insideTo: self.view)
        overlay.add(insideTo: self.view)
        addButton.add(insideTo: overlay.view)
        inputTextField.add(insideTo: overlay.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        configCameraARKitConstraints()
        overlay.applyConstraint()
        addButton.applyConstraint()
        inputTextField.applyConstraint()
    }
    
    private func configCameraARKitConstraints() {
        cameraARKit.makeConstraints { make in
            make
                .setTop.equalTo(titleView.view, .bottom, 5)
                .setPinBottom.equalToSuperView
                .apply()
        }
    }
    
    private func createImageTarget() -> ImageViewBuilder {
        return ImageViewBuilder(UIImage(systemName: K.Sticky.Images.imageTarget))
            .setTintColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setWeight(.thin)
    }
    

}
