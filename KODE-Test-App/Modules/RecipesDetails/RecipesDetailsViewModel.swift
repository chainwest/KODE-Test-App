//
//  RecipesDetaildViewModel.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 19.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Kingfisher

protocol RecipesDetailsViewModelDelegate: class {
    func recipesDetailsViewModelDidFinish(_ viewModel: RecipesDetailsViewModel)
}

class RecipesDetailsViewModel {
    weak var coordinatorDelegate: RecipesDetailsViewModelDelegate?
    
    private(set) var recipeDescription: String?
    private(set) var recipeInstruction: String?
    private(set) var recipeDifficulty: String?
    private(set) var recipeName: String?
    private(set) var imagesLinks: [String]?
    
    private var detailsResult: Recipe?
    
    init(detailsResult: Recipe?) {
        self.detailsResult = detailsResult
        updateDetailsData(detailsResult: detailsResult)
    }
    
    //MARK: - Method for getting and formatting data for details
    
    private func updateDetailsData(detailsResult: Recipe?) {
        recipeName = detailsResult?.name
        recipeDescription = detailsResult?.description
        recipeInstruction = detailsResult?.instructions.replacingOccurrences(of: "<br>", with: "\n\n")
        recipeDifficulty = "Difficulty: \(detailsResult?.difficulty ?? 1)"
        imagesLinks = detailsResult?.images
    }
    
    func close() {
        coordinatorDelegate?.recipesDetailsViewModelDidFinish(self)
    }
}
