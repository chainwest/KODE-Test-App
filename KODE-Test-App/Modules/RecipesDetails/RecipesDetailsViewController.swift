//
//  RecipesDetailsViewController.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit
import Kingfisher
import Auk

class RecipesDetailsViewController: UIViewController {
    
    private let viewModel: RecipesDetailsViewModel?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    init(viewModel: RecipesDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        viewModel?.close()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    private func updateData() {
        nameLabel.text = viewModel?.recipeName
        descriptionLabel.text = viewModel?.recipeDescription
        instructionsLabel.text = viewModel?.recipeInstruction
        difficultyLabel.text = viewModel?.recipeDifficulty
        setupScrollView()
    }
    
    private func setupScrollView() {
        scrollView.layer.masksToBounds = true
        scrollView.layer.cornerRadius = 10
        scrollView.auk.settings.pageControl.backgroundColor = .clear
        scrollView.auk.settings.pageControl.pageIndicatorTintColor = .darkText
        scrollView.auk.settings.contentMode = .scaleAspectFill
        
        if let links = viewModel?.imagesLinks {
            for link in links {
                scrollView.auk.show(url: link)
            }
        }
    }

}
