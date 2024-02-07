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
    func redoButtonTapped()
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
        applyNeumorphism() 
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
    
    lazy var cameraARKit: ARSceneViewBuilder = {
        let arKit = ARSceneViewBuilder()
            .setImageTarget(image: createImageTarget())
            .setEnabledTargetDraggable(false)
            .setAlignmentTarget(.top, 174)
            .setBorder { build in
                build
                    .setCornerRadius(20)
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(titleView.view, .bottom, 5)
                    .setPinBottom.equalToSuperView
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
                    .setPinBottom.equalTo(cameraARKit.view)
                    .setHeight.equalToConstant(90)
            }
        return view
    }()
    
    lazy var descriptionLabel: LabelBuilder = {
        let label = LabelBuilder()
        return label
    }()
    
    lazy var noteTextField: TextFieldClearableBuilder = {
        let tf = TextFieldClearableBuilder("Enter your note")
            .setFont(UIFont.systemFont(ofSize: 15, weight: .regular))
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setTextColor(Theme.shared.currentTheme.onSurface)
            .setPlaceHolderColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setPadding(10, .left)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
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
    
    lazy var redoButtonStickyAR: IconButtonBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "arrowshape.turn.up.backward.fill"))
        let tf = IconButtonBuilder(img.view)
            .setHidden(true)
            .setImageSize(25)
            .setImageColor(Theme.shared.currentTheme.onSurface.adjustBrightness(10))
            .setConstraints { build in
                build
                    .setTop.setLeading.equalToSuperView(10)
                    .setWidth.setHeight.equalToConstant(40)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(redoButtonTapped), .touchUpInside)
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
    
    @objc private func redoButtonTapped() {
        delegate?.redoButtonTapped()
    }
    
    
//  MARK: - GET Area
    func getStickyNote() -> UIView {
        return createStickyNoteView(noteTextField.getText)
    }
    
    func recreateStickyNote(_ note: String) -> UIView {
        return createStickyNoteView(note)
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
        Utils.configNeumorphisFloatView(self)
    }
    
    private func addElements() {
        titleView.add(insideTo: self.view)
        cameraARKit.add(insideTo: self.view)
        overlay.add(insideTo: self.view)
        addButton.add(insideTo: overlay.view)
        noteTextField.add(insideTo: overlay.view)
        redoButtonStickyAR.add(insideTo: self.cameraARKit.view)
    }
    
    private func configConstraints() {
        titleView.applyConstraint()
        cameraARKit.applyConstraint()
        overlay.applyConstraint()
        addButton.applyConstraint()
        noteTextField.applyConstraint()
        redoButtonStickyAR.applyConstraint()
    }
        
    private func createImageTarget() -> ImageViewBuilder {
        return ImageViewBuilder(UIImage(systemName: K.Sticky.Images.imageTarget))
            .setTintColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setWeight(.thin)
    }
    

    
//  MARK: - STICKY AR Area
    private func createStickyNoteView(_ note: String) -> UIView {
        let view = createSticky()
        let top = createTopSticky()
        let note = createLabel(note)
        top.add(insideTo: view.view)
        note.add(insideTo: view.view)
        return view.view
    }
    
    private func createLabel(_ note: String) -> LabelBuilder {
        return LabelBuilder(frame: CGRect(x: K.Sticky.AR.Frame.Note.x,
                                          y: K.Sticky.AR.Frame.Note.y,
                                          width: K.Sticky.AR.Frame.Note.width,
                                          height: K.Sticky.AR.Frame.Note.height))
        
        .setTextAlignment(.natural)
        .setFont(UIFont.systemFont(ofSize: K.Sticky.AR.fontSizeNote, weight: .regular))
        .setColor(Theme.shared.currentTheme.onPrimary)
        .setNumberOfLines(0)
        .setText(note)
    }
    
    private func createSticky() -> ViewBuilder {
        return ViewBuilder(frame: CGRect(x: K.Sticky.AR.Frame.Default.x,
                                         y: K.Sticky.AR.Frame.Default.y,
                                         width: K.Sticky.AR.Frame.Default.width,
                                         height: K.Sticky.AR.Frame.Default.height))
            .setBackgroundColor(K.Sticky.corSticky)
            .setBorder { build in
                build
                    .setCornerRadius(K.Sticky.AR.Frame.cornerRadius)
            }
    }
    
    private func createTopSticky() -> ViewBuilder {
        return ViewBuilder(frame: CGRect(x: K.Sticky.AR.Frame.Top.x,
                                         y: K.Sticky.AR.Frame.Top.y,
                                         width: K.Sticky.AR.Frame.Top.width,
                                         height: K.Sticky.AR.Frame.Top.height))
            .setBackgroundColor(K.Sticky.corSticky.adjustBrightness(-20))
    }
    
    private func applyNeumorphism() {
        DispatchQueue.main.async { [weak self] in
            self?.noteTextField.setNeumorphism({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainerHighest)
                    .setShape(.concave)
                    .setIntensity(to: .light, percent: 80)
                    .setBlur(to: .light, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .apply()
            })
        }
    }
    

}
