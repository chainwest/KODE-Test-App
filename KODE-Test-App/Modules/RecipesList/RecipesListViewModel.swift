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
    
    private(set) var recipesList: Response?
    private(set) var numberOfRows = 0
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getRecipes() {
        apiService.getRecipesList { response in
            switch response {
            case .success(let data):
                self.recipesList = data
                
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
        let recipeResult = recipesList?.recipes![indexPath.row]
        delegate?.recipesListViewModelDidRequestShowDetails(recipeResult: recipeResult)
    }
    
    //MARK: - Search bar filter method
    
    func filterRecipes(input: String) {
        let recipes = self.recipesList?.recipes?.filter({ recipe -> Bool in
            return (recipe.name + " " + recipe.description!).range(of: input, options: [.caseInsensitive]) != nil
        })
    }
}
