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
    
    lazy var screen: WhatBeerView = {
        let view = WhatBeerView()
        return view
    }()
    
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
        UtilsFloatView.setShadowActiveFloatView(screen)
        screen.cameraARKit.runSceneView()
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        UtilsFloatView.removeShadowActiveFloatView(screen)
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
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation] {
                print(results)
                results.forEach { result in
//                    print(result.identifier, result.confidence)
                    if result.confidence > 0.90 {
                        print("############### \(result.identifier) !!!!")
                    }
                }
            }
        }
        return request
    }
    
    private func completionProcessImage() {
        
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
