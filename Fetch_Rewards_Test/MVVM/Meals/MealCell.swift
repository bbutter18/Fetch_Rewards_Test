//
//  MealCell.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/22/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation
import UIKit

class MealCell: UITableViewCell {
    
    static let reuseIdentifier = "MealCell"
    
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealId: UILabel!
    
    func configure(with viewModel: MealViewModel) {
        mealName.text = "\(viewModel.nameValue)"
        mealId.text = "\(viewModel.idValue)"
    }
    
}
