//
//  RecipesListViewModel.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Kingfisher

protocol RecipesListViewModelDelegate: class {
    func recipesListViewModelDidRequestShowDetails(recipeResult: Recipe?)
}

class RecipesListViewModel {
    weak var delegate: RecipesListViewModelDelegate?
    
    var onDidUpdate: (() -> Void)?
    
    private(set) var recipesList: [Recipe]?
    private(set) var filteredRecipesList: [Recipe]?
    private(set) var numberOfRows = 0
    private(set) var state = 0
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getRecipes() {
        apiService.getRecipesList { response in
            switch response {
            case .success(let data):
                self.recipesList = data.recipes?.sorted(by: { (first, second) -> Bool in
                    first.lastUpdated < second.lastUpdated
                })
                
                self.filteredRecipesList = self.recipesList
                
                if let counter = data.recipes?.count {
                    self.numberOfRows = counter
                }
                
                self.onDidUpdate?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelectCell(indexPath: IndexPath) {
        let recipeResult = recipesList?[indexPath.row]
        delegate?.recipesListViewModelDidRequestShowDetails(recipeResult: recipeResult)
    }
    
    func setupCellContent(cell: RecipesListCell, indexPath: IndexPath) {
        let url = URL(string: recipesList![indexPath.row].images[0])
        
        cell.recipeImage.kf.setImage(with: url)
        cell.titleLabel.text = recipesList![indexPath.row].name
        cell.descriptionLabel.text = recipesList![indexPath.row].description ?? "Ooups, there is no description!"
    }
    
    //MARK: - Search bar filter method
    
    func filterRecipes(input: String) {
        guard !input.isEmpty else {
          updateRecipes(recipes: recipesList)
          return
        }
        
        filteredRecipesList = recipesList?.filter({ recipe -> Bool in
            return recipe.name.lowercased().contains(input.lowercased()) || recipe.instructions.lowercased().contains(input.lowercased())
        })
        updateRecipes(recipes: filteredRecipesList)
    }
    
    private func updateRecipes(recipes: [Recipe]?) {
        self.recipesList? = recipes!
        self.numberOfRows = recipesList!.count
        onDidUpdate?()
    }
    
    //MARK: - Sort table rows method for button
    
    @objc func sortTableViewRows(sender: UIButton!) {
        if state == 0 {
            recipesList!.sort(by: { (first, second) -> Bool in
                first.name < second.name
            })
            state = 1
        } else {
            recipesList!.sort(by: { (first, second) -> Bool in
                first.lastUpdated < second.lastUpdated
            })
            state = 0
        }
        onDidUpdate?()
    }
}
