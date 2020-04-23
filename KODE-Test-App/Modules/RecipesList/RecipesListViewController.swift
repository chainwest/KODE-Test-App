//
//  RecipesListViewController.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit
import Kingfisher

class RecipesListViewController: UITableViewController {
    
    private let viewModel: RecipesListViewModel
    
    init(viewModel: RecipesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        viewModel.getRecipes()
        bindToViewModel()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "RecipesListCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
    }
    
    private func bindToViewModel() {
        viewModel.onDidUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! RecipesListCell
        
        viewModel.setupCellContent(cell: cell, indexPath: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCell(indexPath: indexPath)
    }
    
}
