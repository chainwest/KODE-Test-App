//
//  RecipesListViewModel.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit
import Kingfisher

protocol RecipesListViewModelDelegate: class {
    func recipesListViewModelDidRequestShowDetails(recipeResult: Recipe?)
}

class RecipesListViewModel {
    weak var delegate: RecipesListViewModelDelegate?
    
    var onDidUpdate: (() -> Void)?
    
    private(set) var recipesList: [Recipe]?
    private(set) var filteredRecipesList: [Recipe]?
    private(set) var errorFromServer: Error?
    private(set) var numberOfRows = 0
    
    private let repository: DataRepository
    
    init(repository: DataRepository) {
        self.repository = repository
        self.getRecipes()
    }
    
    func getRecipes() {
        HelpValues.loadingFlag = true
        repository.getRecipes { response in
            HelpValues.loadingFlag = false
            switch response {
            case .success(let data):
                self.recipesList = data
                self.filteredRecipesList = self.recipesList
                self.sortData()
                self.filterRecipes(input: HelpValues.lowercasedInput)
                self.onDidUpdate?()
            case .failure(let error):
                self.errorFromServer = error
            }
        }
    }
    
    func didSelectCell(indexPath: IndexPath) {
        HelpValues.sortFlag = !HelpValues.sortFlag
        let recipeResult = filteredRecipesList?[indexPath.row]
        delegate?.recipesListViewModelDidRequestShowDetails(recipeResult: recipeResult)
    }
    
    func setupCellContent(cell: RecipesListCell, indexPath: IndexPath) {
        let url = URL(string: filteredRecipesList![indexPath.row].images[0])
        
        cell.recipeImage.kf.setImage(with: url)
        cell.titleLabel.text = filteredRecipesList![indexPath.row].name
        cell.descriptionLabel.text = filteredRecipesList![indexPath.row].description
    }
    
    //MARK: - Search bar filter method
    
    func filterRecipes(input: String) {
        HelpValues.lowercasedInput = input.lowercased()
        
        guard !input.isEmpty else {
          updateRecipes()
          return
        }
        
        filteredRecipesList = recipesList?.filter { recipe -> Bool in
            recipe.name.lowercased().contains(HelpValues.lowercasedInput) ||
            recipe.instructions.lowercased().contains(HelpValues.lowercasedInput) ||
            recipe.description!.lowercased().contains(HelpValues.lowercasedInput)
        }
        updateRecipes()
    }
    
    private func updateRecipes() {
        self.numberOfRows = filteredRecipesList!.count
        onDidUpdate?()
    }
    
    //MARK: - Sort table rows method for button
    
    @objc func sortTableViewRows(sender: UIButton!) {
        sortData()
    }
    
    private func sortData() {
        if HelpValues.sortFlag == true {
            filteredRecipesList!.sort { first, second -> Bool in
                first.name < second.name
            }
            HelpValues.sortFlag = false
        } else if HelpValues.sortFlag == false {
            filteredRecipesList!.sort { first, second -> Bool in
                first.lastUpdated < second.lastUpdated
            }
            HelpValues.sortFlag = true
        }
        onDidUpdate?()
    }
}
