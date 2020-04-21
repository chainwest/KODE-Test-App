//
//  RecipesListCell.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class RecipesListCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView! {
        didSet {
            recipeImage.layer.masksToBounds = true
            recipeImage.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
