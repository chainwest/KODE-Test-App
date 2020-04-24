//
//  SearchResultUpdater.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 18.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class SearchResultsUpdater: NSObject, UISearchResultsUpdating {
    private var viewModel: RecipesListViewModel
      
    init(viewModel: RecipesListViewModel) {
        self.viewModel = viewModel
    }
      
    // MARK: - Update data in table
      
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchInput = searchController.searchBar.text else { return }
        
        viewModel.filterRecipes(input: searchInput)
        
        if !searchController.isActive {
            viewModel.getRecipes()
        }
    }
}
