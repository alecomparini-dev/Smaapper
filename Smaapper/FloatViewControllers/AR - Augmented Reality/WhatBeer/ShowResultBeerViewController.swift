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
        showResultView.configResultListConstraint()
    }
    
    private func setBeerLabel() {
        showResultView.beerLabel.setText(self.beer?.title ?? "")
    }
    
    private func populateResultList() {
        guard let beer else {return}
        
        let sectionInformation = createSection("Info")
        let sectionOriginated = createSection("Original de")
        let sectionNutritional = createSection("Inf. Nutricional")
        let sectionAllergic = createSection("Alérgicos")
        
        showResultView.resultList.populateSection(sectionInformation)
        createRow(sectionInformation, "Teor Alcólico: \(beer.alcohol)% vol. alc.")
        createRow(sectionInformation, "Fabricante: \(beer.manufacturer)")
        
        showResultView.resultList.populateSection(sectionOriginated)
        createRow(sectionOriginated, "\(beer.originated.city) / \(beer.originated.country) ")
        
        showResultView.resultList.populateSection(sectionNutritional)
        createRow(sectionNutritional, "Referência: \(beer.nutritionalValues.reference)")
        createRow(sectionNutritional, "Calorias: \(beer.nutritionalValues.calories) kcal")
        
        showResultView.resultList.populateSection(sectionAllergic)
        beer.allergic.forEach { item in
            createRow(sectionAllergic, item)
        }
        
        showResultView.resultList.isShow = true
    }
    
    private func createSection(_ label: String) -> Section {
        let section = Section(
            leftView: UIView(frame: .zero),
            middleView: LabelBuilder(label)
                .setFont(UIFont.systemFont(ofSize: 21, weight: .bold))
                .setColor(Theme.shared.currentTheme.onSurfaceVariant)
                .view
        )
        return section
    }
    
    private func createRow(_ section: Section, _ text: String) {
        let row = Row(
            leftView: UIView(),
            middleView:
                LabelBuilder(text)
                .setNumberOfLines(2)
                .setFont(UIFont.systemFont(ofSize: 15, weight: .regular))
                .setColor(Theme.shared.currentTheme.onSurface)
                .view,
            rightView: nil)
        showResultView.resultList.populateRowInSection(section, row)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
