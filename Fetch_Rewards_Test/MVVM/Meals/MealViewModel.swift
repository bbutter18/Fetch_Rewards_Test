//
//  ViewModel.swift
//  Fetch_Rewards_Test
//
//  Created by Blastoise on 1/22/22.
//  Copyright © 2022 Blastoise's Deluge, LLC. All rights reserved.
//

import Foundation


struct MealViewModel {
    let nameValue: String
    let idValue: String
    
    init(model: Meal) {
        self.nameValue = model.name ?? ""
        self.idValue = model.id ?? ""
    }
}
