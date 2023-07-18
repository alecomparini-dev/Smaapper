//
//  ShowResultPredictionViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 17/07/23.
//

import UIKit

class ShowResultBeerViewController: ViewBuilder {
    
    private let viewModel: WhatBeerViewModel = WhatBeerViewModel()
    private let result: String
    
    private var beer: BeerData?
    
    lazy var showResultView: ShowResultBeerView = {
        let view = ShowResultBeerView(self.result)
        return view
    }()
    
    init(_ result: String) {
        self.result = result
        super.init()
        initialization()
    }
    
    private func initialization() {
        configShowResultBeerView()
        fetchResultBeer()
    }
    
    
//  MARK: - SET DELEGATE
    func setDelegate(_ delegate: ShowResultBeerViewDelegate) {
        showResultView.delegate = delegate
    }

    
//  MARK: - PRIVATE Area
    private func configShowResultBeerView() {
        self.view = showResultView
    }
    
    private func fetchResultBeer() {
        Task {
            do {
                self.beer = try await viewModel.fetchBeer(.file, result)
                print(beer ?? "" )
                DispatchQueue.main.async { [weak self] in
                    self?.refreshInterface()
                }
            } catch let error {
                print("Error fetch Beer", error.localizedDescription)
            }
            
        }
    }
    
    private func refreshInterface() {
        setBeerLabel()
        populateResultList()
    }
    
    private func setBeerLabel() {
        showResultView.beerLabel.setText(self.beer?.title ?? "")
    }
    
    private func populateResultList() {
        
    }
    
    
}
