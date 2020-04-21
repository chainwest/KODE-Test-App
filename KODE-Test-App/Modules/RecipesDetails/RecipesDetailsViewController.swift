//
//  RecipesDetailsViewController.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit
import Kingfisher

class RecipesDetailsViewController: UIViewController {
    
    private let viewModel: RecipesDetailsViewModel?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
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
        setupStackView(viewModel?.imagesLinks)
    }
    
    private func setupStackView(_ linksList: [String]?) {
        for link in 0..<linksList!.count {
            let imageView = UIImageView()
            let url = URL(string: linksList![link])
            
            imageView.kf.setImage(with: url!)
            
            let xPosition = stackView.bounds.width * CGFloat(link)
            imageView.frame = CGRect(x: xPosition, y: 0, width: stackView.frame.width, height: stackView.frame.height)
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 10
            imageView.contentMode = .scaleToFill
            
            stackView.addArrangedSubview(imageView)
        }
    }

}
