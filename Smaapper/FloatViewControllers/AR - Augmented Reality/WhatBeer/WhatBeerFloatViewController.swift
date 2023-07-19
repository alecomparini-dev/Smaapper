//
//  WhatBeerFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/07/23.
//

import UIKit
import Vision

class WhatBeerFloatViewController: FloatViewController {
    static let identifierApp = K.WhatBeer.identifierApp
    
    private var showResultBeerView: ShowResultBeerViewController?
    private var animation: CAAnimationBuilder?
    
    lazy var screen: WhatBeerView = {
        let view = WhatBeerView()
        return view
    }()
    
    deinit {
        showResultBeerView = nil
    }
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEnabledDraggable(true)
        setFrameWindow(CGRect(x: K.WhatBeer.FloatView.x,
                              y: K.WhatBeer.FloatView.y,
                              width: K.WhatBeer.FloatView.width ,
                              height: K.WhatBeer.FloatView.height))
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        Utils.setShadowActiveFloatView(screen)
        screen.cameraARKit.runSceneView()
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        Utils.removeShadowActiveFloatView(screen)
        screen.cameraARKit.pauseSceneView()
    }
    
    
    //  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
    }
    
    private func processCapture() throws {
        let beerModel: VNCoreMLModel = try loadBeerModel()
        let snapShot: UIImage = try captureImage()
        let ciImage: CIImage = try convertToCIImage(snapShot)
        let requestHandler: VNImageRequestHandler = createRequestHandler(ciImage: ciImage)
        let request: VNCoreMLRequest = createRequestModel(beerModel)
        try performModel(requestHander: requestHandler, request: request )
    }
    
    private func performModel(requestHander: VNImageRequestHandler, request: VNCoreMLRequest ) throws {
        try requestHander.perform([request])
    }
    
    private func createRequestHandler(ciImage: CIImage) -> VNImageRequestHandler {
        return VNImageRequestHandler(ciImage: ciImage)
    }
    
    private func captureImage() throws -> UIImage {
        if let imageCam = screen.cameraARKit.getPrint() {
            return imageCam
        }
        throw CoreMLError.convertToCIImage(error: "Unable to capture image.")
    }
    
    private func convertToCIImage(_ image: UIImage) throws -> CIImage {
        if let ciImage = CIImage(image: image){
            return ciImage
        }
        throw CoreMLError.convertToCIImage(error: "Unable to convert image to CIImage")
    }
    
    private func loadBeerModel() throws -> VNCoreMLModel {
        do {
            return try VNCoreMLModel(for: Beer(configuration: MLModelConfiguration()).model)
        } catch let error {
            throw CoreMLError.loadBeerModel(error: error.localizedDescription)
        }
    }
    
    private func createRequestModel(_ model: VNCoreMLModel) -> VNCoreMLRequest{
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let self else {return}
            if error != nil {
                print("Mensagem para retentar porque deu falha", error?.localizedDescription ?? "")
                return
            }
            completionSuccessProcessImage(request)
        }
        return request
    }
    
    private func getResultRequest(_ request: VNRequest) -> [String] {
        var identifiers:[String] = []
        if let results = request.results as? [VNClassificationObservation] {
            results.forEach { result in
                switch result.confidence {
                case 0.98...1.0:
                    identifiers.append(result.identifier)
                case 0.95...0.979:
                    identifiers.append(result.identifier)
                case 0.90...0.949:
                    identifiers.append(result.identifier)
                case 0.80...0.899:
                    identifiers.append(result.identifier)
                default:
                    break
                }
            }
        }
        return identifiers
    }
    
    private func flowForUnidentifiedBeer() {
        print("criar fluxo para solicitar nova tentiva")
    }
    
    private func flowForMultipleIdentifiedBeers(_ result: [String]) {
        print("criar fluxo para mais de um chop identificado")
    }
    
    private func flowForSingleIdentifiedBeer(_ result: [String]) {
        if let result = result.first {
            configShowResult(result)
        }
    }
    
    private func completionSuccessProcessImage(_ request: VNRequest) {
        let result = getResultRequest(request)
        
        switch result.count {
            case .zero:
                flowForUnidentifiedBeer()
            case 1:
                flowForSingleIdentifiedBeer(result)
            default:
                flowForMultipleIdentifiedBeers(result)
        }
    }
    
    private func configShowResult(_ result: String) {
        screen.showResult.setHidden(false)
        createShowResultBeer(result)
        showViewResultBeerAnimation()
    }
    
    private func configDelegateShowResultBeer() {
        showResultBeerView?.setDelegate(self)
    }
    
    private func createShowResultBeer(_ result: String) {
        self.showResultBeerView = ShowResultBeerViewController(result)
        addShowResultBeer()
        configShowResultBeerConstraints()
        configDelegateShowResultBeer()
    }
    
    private func addShowResultBeer() {
        showResultBeerView?.add(insideTo: screen.showResult.view)
    }
    
    private func configShowResultBeerConstraints() {
        showResultBeerView?.setConstraints { build in
            build
                .setPin.equalToSuperView
                .apply()
        }
    }

    private func configCloseResultBeer() {
        screen.cameraARKit.pauseSceneView()
        screen.cameraARKit.runSceneView()
        hideViewResultBeerAnimation { [weak self] in
            guard let self else {return}
            animation = nil
        }
    }

    
//  MARK: - ANIMATION Area
    private func showViewResultBeerAnimation() {
        animation = CAAnimationBuilder()
            .setTransitionAnimation { build in
                build
                    .setDuration(0.5)
                    .setType(.push)
                    .setTimingFunction(.easeInEaseOut)
                    .setSubtype(.fromRight)
                    .play(screen.showResult.view)
            }
    }
    
    private func hideViewResultBeerAnimation(completion: @escaping () -> Void) {
        animation?.transition?
            .setSubtype(.fromLeft)
            .play(screen.showResult.view, completion: completion)
        
        showResultBeerView?.view.removeFromSuperview()
        screen.showResult.setHidden(true)
    }
    

    
}


//  MARK: - EXTENSION WhatBeerViewDelegate
extension WhatBeerFloatViewController: WhatBeerViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
    func captureTapped() {
        do {
            try processCapture()
        } catch let error {
            print(error.localizedDescription)
        }
        screen.cameraARKit.pauseSceneView()
    }
    
}


//  MARK: - EXTENSION ShowResultBeerViewDelegate
extension WhatBeerFloatViewController: ShowResultBeerViewDelegate {
    
    func closeResultBeer() {
        configCloseResultBeer()
    }
    
    
}
