//
//  RecipesDetailsCoordinator.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 19.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

protocol RecipesDetailsCoordinatorDelegate: class {
    func didFinish(from coordinator: RecipesDetailsCoordinator)
}

class RecipesDetailsCoordinator: Coordinator {
    private let rootViewController: UINavigationController
    private var viewModel: RecipesDetailsViewModel?
    private var recipesList: Recipe?
    
    weak var coordinatorDelegate: RecipesDetailsCoordinatorDelegate?
    
    init(rootViewController: UINavigationController, recipesList: Recipe?) {
        self.rootViewController = rootViewController
        self.recipesList = recipesList
    }
    
    override func start() {
        viewModel = RecipesDetailsViewModel(detailsResult: recipesList)
        guard let viewModel = viewModel else { return }
        viewModel.coordinatorDelegate = self
        let detailsVC = RecipesDetailsViewController(viewModel: viewModel)
        setupNavigationBar(viewController: detailsVC)
        rootViewController.pushViewController(detailsVC, animated: true)
    }
    
    private func setupNavigationBar(viewController: UIViewController) {
        viewController.navigationItem.title = "Details"
        viewController.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func finish() {
        coordinatorDelegate?.didFinish(from: self)
    }
}

extension RecipesDetailsCoordinator: RecipesDetailsViewModelDelegate {
    func recipesDetailsViewModelDidFinish(_ viewModel: RecipesDetailsViewModel) {
        finish()
    }
}
