//
//  RecipesListCoordinator.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class RecipesListCoordinator: Coordinator {
    private let rootViewController: UINavigationController
    private var searchResultsUpdater: SearchResultsUpdater?

    var viewModel: RecipesListViewModel = {
        let apiService = ApiService()
        let viewModel = RecipesListViewModel(apiService: apiService)
        return viewModel
    }()

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    override func start() {
        viewModel.delegate = self
        searchResultsUpdater = SearchResultsUpdater(viewModel: viewModel)
        let recipesVC = RecipesListViewController(viewModel: viewModel)
        setupNavigationBar(viewController: recipesVC)
        rootViewController.setViewControllers([recipesVC], animated: false)
    }
    
    func setupNavigationBar(viewController: UIViewController) {
        rootViewController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = "Recipe book"
        viewController.navigationItem.largeTitleDisplayMode = .always
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = searchResultsUpdater
        searchController.obscuresBackgroundDuringPresentation = false
        viewController.navigationItem.searchController = searchController
        viewController.navigationItem.hidesSearchBarWhenScrolling = true
        
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: viewModel, action: #selector(viewModel.sortTableViewRows))
    }
}

extension RecipesListCoordinator: RecipesListViewModelDelegate {
    func recipesListViewModelDidRequestShowDetails(recipeResult: Recipe?) {
        let recipesDetailsCoordinator = RecipesDetailsCoordinator(rootViewController: rootViewController, recipesList: recipeResult)
        recipesDetailsCoordinator.coordinatorDelegate = self
        addChildCoordinator(recipesDetailsCoordinator)
        recipesDetailsCoordinator.start()
    }
}

extension RecipesListCoordinator: RecipesDetailsCoordinatorDelegate {
    func didFinish(from coordinator: RecipesDetailsCoordinator) {
        viewModel.getRecipes()
    }
}
