//
//  CustomCell.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/20/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation
import UIKit

class CategoryCell: UITableViewCell {
    
    static let reuseIdentifier = "Cell"
    
    @IBOutlet weak var category: UILabel!

    func configure(with viewModel: ViewModel) {
        category.text = "\(viewModel.nameValue)"
    }
    
    
    
    
}
