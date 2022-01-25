//
//  ViewModel.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/20/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation

struct ViewModel {
    let nameValue: String
    
    init(model: Category) {
        self.nameValue = model.name ?? ""
    }
}
